//
//  NDSegmentView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h> /*** 选项卡条 ***/

@class NDSegmentParam;
@interface NDSegmentView : UIView

/*** 初始化选项卡 ***/
- (instancetype)initWithFrame:(CGRect)frame segmentParam:(NDSegmentParam *)segmentParam;

/*** 更新数据源 ***/
- (void)reloadDataArray:(NSArray<NSString *> *)data;
- (void)setAssociatedScroll;
- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;

@property (nonatomic ,copy) void(^selectedIndexBlock)(NSInteger index);
@property (nonatomic ,copy) void(^associatedScrollBlock)(UIScrollView *scrollView);
@end
