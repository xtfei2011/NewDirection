//
//  NDBannerView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NDBannerView ,NDBanner;
typedef void(^BannerViewClick)(NDBannerView *bannerView ,NSString *url);

@interface NDBannerView : UIView

/*** 数据源 ***/
@property (nonatomic ,strong) NSMutableArray<NDBanner *> *banner;
/*** 图片点击回调 ***/
@property (nonatomic ,copy) BannerViewClick bannerClick;
/*** 点击事件 Block ***/
- (void)bannerViewClick:(void(^)(NDBannerView *barnerView ,NSString *url))block;
@end
