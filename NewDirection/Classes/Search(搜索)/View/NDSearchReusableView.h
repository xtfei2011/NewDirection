//
//  NDSearchReusableView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NDSearchReusableView;
@protocol NDSearchReusableViewDelegate <NSObject>
- (void)delectButtonClick:(NDSearchReusableView *)view;
@end

@interface NDSearchReusableView : UICollectionReusableView

@property (nonatomic ,strong) UIButton *delectBtn;
@property (nonatomic ,strong) NSString *title;

@property (nonatomic ,weak) id<NDSearchReusableViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
