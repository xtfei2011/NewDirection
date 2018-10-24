//
//  NDPlayerConfig.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/30.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*** 全屏状态下状态栏显示方式 ***/
typedef NS_ENUM(NSInteger, SelStatusBarHideState)
{
    SelStatusBarHideStateFollowControls = 0, //跟随控制面板显示
    SelStatusBarHideStateNever, //从不显示
    SelStatusBarHideStateAlways, //一直显示
};

@interface NDPlayerConfig : NSObject

/*** 视频数据源 ***/
@property (nonatomic ,strong) NSURL *video_url;

/*** 是否自动播放 ***/
@property (nonatomic ,assign) BOOL voluntarilyPlay;

/*** 是否重复播放 ***/
@property (nonatomic ,assign) BOOL repeatPlay;

/*** 是否支持双击暂停或播放 ***/
@property (nonatomic ,assign) BOOL supportedDoubleTap;

/*** 是否支持自动转屏 ***/
@property (nonatomic ,assign) BOOL shouldAutorotate;

/*** 隐藏控制面板延时时间 ***/
@property (nonatomic ,assign) NSTimeInterval hideControlsInterval;

/*** 全屏状态下状态栏显示方式 ***/
@property (nonatomic ,assign) SelStatusBarHideState statusBarHideState;

@end
