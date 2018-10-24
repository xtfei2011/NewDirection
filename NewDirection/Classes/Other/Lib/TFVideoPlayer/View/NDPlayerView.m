//
//  NDPlayerView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/30.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "NDPlayerConfig.h"
#import "NDPlayerBottomView.h"
#import "NDPlayerSlider.h"

/** 播放器的播放状态 */
typedef NS_ENUM(NSInteger, NDVideoPlayerState) {
    NDVideoPlayerStateFailed,     // 播放失败
    NDVideoPlayerStateBuffering,  // 缓冲中
    NDVideoPlayerStatePlaying,    // 播放中
    NDVideoPlayerStatePause,      // 暂停播放
};

@interface NDPlayerView ()<NDPlayerBottomViewDelegate>

/*** 播放器 ***/
@property (nonatomic ,strong) AVPlayerItem *playerItem;
/*** 播放器item ***/
@property (nonatomic ,strong) AVPlayer *player;
/*** 播放器layer ***/
@property (nonatomic ,strong) AVPlayerLayer *playerLayer;
/*** 是否播放完毕 ***/
@property (nonatomic ,assign) BOOL isFinish;
/*** 是否处于全屏状态 ***/
@property (nonatomic ,assign) BOOL isFullScreen;
/*** 播放器配置信息 ***/
@property (nonatomic ,strong) NDPlayerConfig *playerConfig;
/*** 视频播放控制面板 ***/
@property (nonatomic ,strong) NDPlayerBottomView *playerBottomView;
/*** 非全屏状态下播放器 ***/
@property (nonatomic ,strong) UIView *originalSuperview;
/*** 非全屏状态下播放器 ***/
@property (nonatomic ,assign) CGRect originalRect;
/*** 时间监听器 ***/
@property (nonatomic ,strong) id timeObserve;
/*** 播放器的播放状态 ***/
@property (nonatomic ,assign) NDVideoPlayerState playerState;

/*** 是否结束播放 ***/
@property (nonatomic ,assign) BOOL isOver;

@end

@implementation NDPlayerView

- (instancetype)initWithFrame:(CGRect)frame config:(NDPlayerConfig *)config
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _playerConfig = config;
        
        [self setupPlayer];
        [self setupPlayerBottomView];
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

/*** 屏幕翻转监听事件 ***/
- (void)orientationChanged:(NSNotification *)notify
{
    if (_playerConfig.shouldAutorotate) {
        [self orientationAspect];
    }
}

/*** 根据屏幕旋转方向改变当前视频屏幕状态 ***/
- (void)orientationAspect
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        if (!_isFullScreen) {
            [self videoZoomWithDirection:UIInterfaceOrientationLandscapeRight];
        }
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        if (!_isFullScreen){
            [self videoZoomWithDirection:UIInterfaceOrientationLandscapeLeft];
        }
    } else if (orientation == UIDeviceOrientationPortrait) {
        if (_isFullScreen){
            [self _videoZoomOut];
        }
    }
}

/*** 视频放大全屏幕 ***/
- (void)videoZoomWithDirection:(UIInterfaceOrientation)orientation
{
    _originalSuperview = self.superview;
    _originalRect = self.frame;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    
    [UIView animateWithDuration:duration animations:^{
        
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            self.transform = CGAffineTransformMakeRotation(-M_PI/2);
            
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            self.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    } completion:^(BOOL finished) {}];
    
    self.frame = keyWindow.bounds;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.isFullScreen = YES;
    
    [self.playerBottomView showOrHideStatusBar];
}

/** 视频退出全屏幕 */
- (void)_videoZoomOut
{
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {}];
    
    self.frame = _originalRect;
    [_originalSuperview addSubview:self];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.isFullScreen = NO;
}

/*** 播放视频 ***/
- (void)playVideo
{
    if (self.isOver && self.playerBottomView.videoSlider.value == 1.0) {
        [self replayVideo];
    } else {
        [_player play];
        [self.playerBottomView setPlayButtonSelect:YES];
        if (self.playerState == NDVideoPlayerStatePause) {
            self.playerState = NDVideoPlayerStatePlaying;
        }
    }
}

/** 暂停播放 */
- (void)pauseVideo
{
    [_player pause];
    [self.playerBottomView setPlayButtonSelect:NO];
    if (self.playerState == NDVideoPlayerStatePlaying) {
        self.playerState = NDVideoPlayerStatePause;
    }
}

/** 重新播放 */
- (void)replayVideo
{
    self.isOver = NO;
    [_player seekToTime:CMTimeMake(0, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self playVideo];
}

/** 监听播放器事件 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        /*** 计算缓存进度 ***/
        NSTimeInterval timeInterval = [self computeBufferSchedule];
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [_playerBottomView setPlayerCacheProgress:timeInterval / totalDuration];
        
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        
        /*** 没有缓存时 ***/
        if (self.playerItem.playbackBufferEmpty) {
            self.playerState = NDVideoPlayerStateBuffering;
            
            [self bufferingSomeSecond];
        }
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        
        /*** 当视频缓冲好时 ***/
        if (self.playerItem.playbackLikelyToKeepUp && self.playerState == NDVideoPlayerStateBuffering){
            self.playerState = NDVideoPlayerStatePlaying;
        }
    } else if ([keyPath isEqualToString:@"status"]) {
        
        if (self.player.currentItem.status == AVPlayerStatusReadyToPlay) {
            
            [self setNeedsLayout];
            [self layoutIfNeeded];
            [self.layer insertSublayer:_playerLayer atIndex:0];
            self.playerState = NDVideoPlayerStatePlaying;
            
        } else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
            self.playerState = NDVideoPlayerStateFailed;
        }
    }
}

/*** 计算缓冲进度 ***/
- (NSTimeInterval)computeBufferSchedule
{
    NSArray *loadTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    
    return result;
}

#pragma mark - 缓冲较差时候
- (void)bufferingSomeSecond
{
    self.playerState = NDVideoPlayerStateBuffering;
    
    __block BOOL isBuffering = NO;
    if (isBuffering) return;
    isBuffering = YES;
    
    [self pauseVideo];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self playVideo];
        isBuffering = NO;
        
        if (!self.playerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }
    });
}

/** 应用进入后台 */
- (void)appDidEnterBackground:(NSNotification *)notify
{
    [self pauseVideo];
}

/** 应用进入前台 */
- (void)appDidEnterPlayground:(NSNotification *)notify
{
    
}

/** 视频播放结束事件监听 */
- (void)videoDidPlayToEnd:(NSNotification *)notify
{
    self.isOver = YES;
    if (_playerConfig.repeatPlay) {
        [self replayVideo];
    } else {
        [self pauseVideo];
    }
}

/** 创建播放器 以及控制面板*/
- (void)setupPlayer
{
    self.playerItem = [AVPlayerItem playerItemWithURL:_playerConfig.video_url];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    self.backgroundColor = [UIColor blackColor];
    
    [self createTimer];
    
    if (_playerConfig.voluntarilyPlay) {
        [self playVideo];
    }
}

/** 添加播放器控制面板 */
- (void)setupPlayerBottomView
{
    [self addSubview:self.playerBottomView];
}

/*** 创建定时器 ***/
- (void)createTimer
{
    __weak typeof(self) weakSelf = self;
    
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:nil usingBlock:^(CMTime time) {
        
        AVPlayerItem *currentItem = weakSelf.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            
            NSInteger currentTime = (NSInteger)CMTimeGetSeconds([currentItem currentTime]);
            CGFloat totalTime = (CGFloat)currentItem.duration.value / currentItem.duration.timescale;
            CGFloat value = CMTimeGetSeconds([currentItem currentTime]) / totalTime;
            
            [weakSelf.playerBottomView setPlayerBottomViewWithPlayTime:currentTime totalTime:totalTime sliderValue:value];
        }
    }];
}

/*** 播放器的播放状态 ***/
- (void)setPlayerState:(NDVideoPlayerState)playerState
{
    _playerState = playerState;
    
    switch (_playerState) {
        case NDVideoPlayerStateBuffering:
        {
            [_playerBottomView activityIndicatorViewShow:YES];
        }
            break;
        case NDVideoPlayerStatePlaying:
        {
            [_playerBottomView activityIndicatorViewShow:NO];
        }
            break;
        case NDVideoPlayerStateFailed:
        {
            [_playerBottomView activityIndicatorViewShow:NO];
            [_playerBottomView retryButtonShow:YES];
        }
            break;
        default:
            break;
    }
}

/** 改变全屏切换按钮状态 */
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    _playerBottomView.isFullScreen = isFullScreen;
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem
{
    if (_playerItem == playerItem) return;
    
    if (_playerItem) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    _playerItem = playerItem;
    
    if (playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        // 缓冲区空了，需要等待数据
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        // 缓冲区有足够数据可以播放了
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
}

/*** 播放器控制面板 ***/
- (NDPlayerBottomView *)playerBottomView
{
    if (!_playerBottomView) {
        _playerBottomView = [[NDPlayerBottomView alloc] init];
        _playerBottomView.delegate = self;
        _playerBottomView.hideInterval = _playerConfig.hideControlsInterval;
        _playerBottomView.statusBarHideState = _playerConfig.statusBarHideState;
    }
    return _playerBottomView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
    self.playerBottomView.frame = self.bounds;
}

/** 释放播放器 */
- (void)deallocPlayer
{
    [self pauseVideo];
    
    [self.playerLayer removeFromSuperlayer];
    [self removeFromSuperview];
}

- (void)dealloc
{
    self.playerItem = nil;
    [self.playerBottomView playerCancelAutoHidePlayerBottomView];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
    self.playerLayer = nil;
    self.player = nil;
}

#pragma mark 播放器控制面板代理
/*** 播放按钮点击事件 ***/
- (void)playButtonAction:(BOOL)selected
{
    if (selected) {
        [self pauseVideo];
    } else {
        [self playVideo];
    }
}

/*** 全屏切换按钮点击事件 ***/
- (void)fullScreenButtonAction
{
    if (!_isFullScreen) {
        [self videoZoomWithDirection:UIInterfaceOrientationLandscapeRight];
    } else {
        [self _videoZoomOut];
    }
}

/*** 控制面板单击事件 ***/
- (void)tapGesture
{
    [_playerBottomView playerShowOrHidePlayerBottomView];
}

/*** 控制面板双击事件 ***/
- (void)doubleTapGesture
{
    if (_playerConfig.supportedDoubleTap) {
        if (self.playerState == NDVideoPlayerStatePlaying) {
            [self pauseVideo];
        } else if (self.playerState == NDVideoPlayerStatePause) {
            [self playVideo];
        }
    }
}

/*** 重新加载视频 ***/
- (void)retryButtonAction
{
    [_playerBottomView retryButtonShow:NO];
    [_playerBottomView activityIndicatorViewShow:YES];
    
    [self setupPlayer];
    [self playVideo];
}

#pragma mark 滑杆拖动代理
/*** 开始拖动 ***/
- (void)videoSliderTouchBegan:(NDPlayerSlider *)slider
{
    [self pauseVideo];
    [_playerBottomView playerCancelAutoHidePlayerBottomView];
}

/*** 结束拖动 ***/
- (void)videoSliderTouchEnded:(NDPlayerSlider *)slider
{
    if (slider.value != 1) {
        self.isOver = NO;
    }
    if (!self.playerItem.isPlaybackLikelyToKeepUp) {
        [self bufferingSomeSecond];
    } else {
        [self playVideo];
    }
    [_playerBottomView playerAutoHidePlayerBottomView];
}

/*** 拖拽中 ***/
- (void)videoSliderValueChanged:(NDPlayerSlider *)slider
{
    CGFloat totalTime = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
    CGFloat dragedSeconds = totalTime * slider.value;
    
    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [_player seekToTime:dragedCMTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    NSInteger currentTime = (NSInteger)CMTimeGetSeconds(dragedCMTime);
    
    [_playerBottomView setPlayerBottomViewWithPlayTime:currentTime totalTime:totalTime sliderValue:slider.value];
}
@end
