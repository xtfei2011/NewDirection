//
//  NDSegmentParam.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*** 选项卡基本参数 ***/
@interface NDSegmentParam : NSObject

+ (NDSegmentParam *)defaultParam;

/*** 左右边缘间距 ***/
@property (nonatomic ,assign) CGFloat margin;
/*** 中间间距 ***/
@property (nonatomic ,assign) CGFloat spacing;
/*** 选中的颜色 ***/
@property (nonatomic ,strong) UIColor *selectedColor;
/*** 未选中的颜色 ***/
@property (nonatomic ,strong) UIColor *defaultColor;
/*** 显示底部线 ***/
@property (nonatomic ,assign) BOOL showLine;
/*** 底部线宽 ***/
@property (nonatomic ,assign) CGFloat lineWidth;
/*** 底部线颜色 ***/
@property (nonatomic ,strong) UIColor *lineColor;
/*** 字体大小 ***/
@property (nonatomic ,assign) CGFloat fontSize;
/*** 默认选中的item ***/
@property (nonatomic ,assign) NSInteger startIndex;

@end



/*** 横向滚动 View 基本参数 ***/
@interface NDParallelParam : NSObject

+ (NDParallelParam *)defaultParam;

/*** 头部分栏高度 ***/
@property (nonatomic ,assign) CGFloat headerHeight;
@property (nonatomic ,strong) NDSegmentParam *segmentParam;

@end


/*** 纵向滚动 View 基本参数 ***/
@interface NDVerticalParam : NSObject

+ (NDVerticalParam *)defaultParam;

@property (nonatomic ,strong) NDParallelParam *parallelParam;
/*** 停留的 Y轴 位置 ***/
@property (nonatomic ,assign) CGFloat offset_Y;

@end
