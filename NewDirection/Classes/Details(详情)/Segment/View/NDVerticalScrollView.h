//
//  NDVerticalScrollView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h> /*** 垂直滚动 View ***/
#import "NDParallelScrollView.h"

@class NDVerticalParam ,NDParallelContentView ,NDParallelParam;
@interface NDVerticalScrollView : UIView

@property (nonatomic ,strong ,readonly) NDParallelScrollView *parallelScrollView;

@property (nonatomic ,copy) void(^didScrollBlock)(CGFloat dy);

- (UIScrollView *)scrollView;

- (instancetype)initWithFrame:(CGRect)frame headerView:(UIView *)headerView contentViews:(NSArray<NDParallelContentView *> *)contentViews verticalParam:(NDVerticalParam *)verticalParam;
@end


/*** 记录滚动手势 ***/
@interface NDGestureScrollView : UIScrollView

@property (nonatomic ,weak) NSArray *viewArray;
@end
