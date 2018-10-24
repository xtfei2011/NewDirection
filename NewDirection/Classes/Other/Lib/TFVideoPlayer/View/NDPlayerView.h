//
//  NDPlayerView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/30.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NDPlayerConfig;
@interface NDPlayerView : UIView

/*** 初始化播放器 ***/
- (instancetype)initWithFrame:(CGRect)frame config:(NDPlayerConfig *)config;

/*** 播放视频 ***/
- (void)playVideo;

/*** 暂停播放 ***/
- (void)pauseVideo;

/*** 释放播放器 ***/
- (void)deallocPlayer;
@end
