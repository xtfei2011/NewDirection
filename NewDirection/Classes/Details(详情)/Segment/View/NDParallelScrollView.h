//
//  NDParallelScrollView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h> /*** 平行滚动 ***/

@class NDParallelParam ,NDParallelContentView;
@interface NDParallelScrollView : UIView

@property (nonatomic ,assign) NSInteger currenIndex;

- (instancetype)initWithFrame:(CGRect)frame contentViews:(NSArray<NDParallelContentView *> *)contentViews parallelParam:(NDParallelParam *)parallelParam;
@end
