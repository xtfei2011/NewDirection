//
//  NDSegmentParam.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSegmentParam.h"
#pragma mark ====  这里开发设置所有参数
/*** 选项卡基本参数 ***/
@implementation NDSegmentParam

+ (NDSegmentParam *)defaultParam
{
    return [[NDSegmentParam alloc] init];
}

- (instancetype)init
{
    if ([super init]) {
        
        self.spacing = 5;
        self.margin = 5;
        self.selectedColor = NDColor(80, 85, 101);
        self.defaultColor = [UIColor grayColor];
        self.showLine = YES;
        self.lineWidth = 40;
        self.lineColor = NDColor(80, 85, 101);
        self.fontSize = 14;
        self.startIndex = 0;
    }
    return self;
}
@end


/*** 横向滚动 View 基本参数 ***/
@implementation NDParallelParam

+ (NDParallelParam *)defaultParam
{
    return [[NDParallelParam alloc] init];
}

- (instancetype)init
{
    if ([super init]) {
        self.segmentParam = [NDSegmentParam defaultParam];
        self.headerHeight = 40;
    }
    return self;
}
@end


@implementation NDVerticalParam

+ (NDVerticalParam *)defaultParam
{
    return [[NDVerticalParam alloc] init];
}

- (instancetype)init
{
    if ([super init]) {
        self.parallelParam = [NDParallelParam defaultParam];
        self.offset_Y = 0;
    }
    return self;
}
@end
