//
//  NDAdvertView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/25.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDAdvert.h"

@class NDAdvertView;
@protocol NDAdvertViewDelegate <NSObject>
- (void)advertScrollView:(NDAdvertView *)scrollView selectedIndex:(NSInteger)index;
@end

@interface NDAdvertView : UIView

@property (nonatomic ,strong) NSMutableArray<NDAdvert *> *advert;
@property (nonatomic ,weak) id<NDAdvertViewDelegate> delegate;

/*** 关闭定时器 ***/
- (void)removeTimer;
/*** 添加定时器 ***/
- (void)addTimer;

@end
