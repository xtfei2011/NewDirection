//
//  NDPaymentView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/13.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDPaymentView.h"
#import "NDPaymentInfoView.h"

@interface NDPaymentView ()<NDPaymentInfoViewDelegate>

@property (nonatomic ,strong) NDPaymentInfoView *infoView;

@property (nonatomic ,assign) NDPaymentManner manner;
@property (nonatomic ,strong) NSString *info;
@property (nonatomic ,strong) NSString *money;
@end

@implementation NDPaymentView

- (instancetype)initWithPaymentInfo:(NSString *)info paymentMoney:(NSString *)money paymentManner:(NDPaymentManner)manner
{
    if (self = [super init]) {
        
        self.manner = manner;
        self.info = info;
        self.money = money;
    }
    return self;
}

- (void)show
{
    self.backgroundColor = NDRGBColor(5, 5, 5, 0.3);
    self.frame = NDScreeFrame;
    [NDkeyWindowView addSubview:self];
    
    self.infoView = [NDPaymentInfoView viewFromXib];
    self.infoView.delegate = self;
    self.infoView.moneyLabel.text = self.money;
    self.infoView.infoLabel.text = self.info;
    
    if (self.manner == NDPaymentMannerAlipay) {
        [self.infoView alipayPaymentButtonClick:self.infoView.alipayBtn];
    } else {
        [self.infoView weChatPaymentButtonClick:self.infoView.weChatBtn];
    }
    
    self.infoView.frame = CGRectMake(0, NDMainScreen_Height, NDMainScreen_Width, 350);
    [NDkeyWindowView addSubview:self.infoView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.infoView.transform = CGAffineTransformTranslate(self.infoView.transform, 0, -350);
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.infoView.transform = CGAffineTransformTranslate(self.infoView.transform, 0, 350);
        
    } completion:^(BOOL finished) {
        [self.infoView removeFromSuperview];
        [self removeFromSuperview];
        self.manner = 0;
        self.info = nil;
        self.money = nil;
    }];
}

/*** 关闭视图 ***/
- (void)closePaymentInfoViewButtonClick:(UIButton *)closeButton
{
    [self dismiss];
}

/*** 确认支付 ***/
- (void)countersignPaymentButtonClick:(UIButton *)countersignButton paymentManner:(NDPaymentManner)manner
{
    [self dismiss];
    
    self.manner = manner;
    
    if (manner == NDPaymentMannerAlipay) {
        
        NDLog(@"--->支付宝");
        [[AlipaySDK defaultService] payOrder:nil fromScheme:APPSCHEME callback:^(NSDictionary *resultDic) {
        }];
    } else {
        NDLog(@"--->微信");
    }
}


@end
