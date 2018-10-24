//
//  NDSegmentController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/27.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSegmentController.h"
#import "NDSegmentParam.h"
#import "NDVerticalScrollView.h"
#import "NDParallelContentView.h"
#import "NDWebView.h"
#import "NDTableView.h"
#import "NDSegmentHeaderView.h"
#import "NDPlayerView.h"
#import "NDPlayerConfig.h"

@interface NDSegmentController ()
@property (nonatomic ,strong) NDPlayerView *player;
@property (nonatomic ,strong) NDVerticalScrollView *verticalScrollView;
@property (nonatomic ,strong) NDSegmentHeaderView *headView;
@end

@implementation NDSegmentController

#pragma mark === 懒加载
#pragma mark === 播放器
- (NDPlayerView *)player
{
    if (!_player) {
        NDPlayerConfig *configuration = [[NDPlayerConfig alloc] init];
        configuration.voluntarilyPlay = YES;
        configuration.supportedDoubleTap = YES;
        configuration.shouldAutorotate = YES;
        configuration.repeatPlay = YES;
        configuration.statusBarHideState = SelStatusBarHideStateFollowControls;
        configuration.video_url = [NSURL URLWithString:@"http://37273.long-vod.cdn.aodianyun.com/u/37273/mp4/1280x720/720-2026c3652394336a88b691a84c7783c1.mp4"];
        
        _player = [[NDPlayerView alloc]initWithFrame:CGRectMake(0, NDNavigationBarH, NDMainScreen_Width, PlayerHeight) config:configuration];
        [self.view addSubview:_player];
    }
    return _player;
}

- (NDVerticalScrollView *)verticalScrollView
{
    if (_verticalScrollView == nil) {
        
        NDParallelContentView *detail = [[NDWebView alloc] initWithSegmentTitle:@"详情"];
        NDParallelContentView *catalog = [[NDTableView alloc] initWithSegmentTitle:@"目录"];
        
        NSArray *vc = @[detail ,catalog];
        
        NDVerticalParam *param = [[NDVerticalParam alloc] init];
        param.parallelParam.segmentParam.startIndex = 0;
        param.parallelParam.headerHeight = 40;
        param.offset_Y = 0;
        
        _verticalScrollView = [[NDVerticalScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_player.frame), self.view.xtfei_width, self.view.xtfei_height - CGRectGetMaxY(_player.frame)) headerView:self.headView contentViews:vc verticalParam:param];
        
        __weak NDSegmentController *weakSelf = self;
        
        _verticalScrollView.didScrollBlock = ^(CGFloat dy) {
            [weakSelf didScroll:dy];
        };
        [self.view addSubview:_verticalScrollView];
    }
    return _verticalScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"课程详情";
    
    [self player];
    
    [self verticalScrollView];
    
    if (@available(iOS 11.0, *)) {
        [self.verticalScrollView scrollView].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didScroll:(CGFloat)dy
{
    CGRect rect = self.headView.bounds;
    if (dy < 0) {rect.size.height -= dy;}
    self.headView.imageView.bounds = rect;
}

- (NDSegmentHeaderView *)headView
{
    if (_headView == nil) {
        _headView = [NDSegmentHeaderView viewFromXib];
        _headView.frame = CGRectMake(0, 0, NDMainScreen_Width, 170);
    }
    return _headView;
}

- (void)dealloc
{
    [self.player deallocPlayer];
}
@end

