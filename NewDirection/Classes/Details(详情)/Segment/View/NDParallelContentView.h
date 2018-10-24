//
//  NDParallelContentView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NDParallelContentView : UIView

@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,assign) NSInteger index;

@property (nonatomic ,copy) void(^didAddScrollViewBlock)(UIScrollView *scrollView ,NSInteger index);

- (instancetype)initWithSegmentTitle:(NSString *)title;
- (void)refreshContentView;
@end
