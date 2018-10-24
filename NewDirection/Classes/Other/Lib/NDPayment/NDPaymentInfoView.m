//
//  NDPaymentInfoView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/13.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDPaymentInfoView.h"

@interface NDPaymentInfoView ()

@end

@implementation NDPaymentInfoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.alipayBtn.layer.borderWidth = 2;
    self.alipayBtn.layer.borderColor = NDColor(69, 133, 245).CGColor;
    [self.alipayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.alipayBtn setTitleColor:NDColor(69, 133, 245) forState:UIControlStateSelected];
    
    self.weChatBtn.layer.borderWidth = 1;
    self.weChatBtn.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.5].CGColor;
    [self.weChatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.weChatBtn setTitleColor:NDColor(69, 133, 245) forState:UIControlStateSelected];
}

/*** 关闭视图 ***/
- (IBAction)closeButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(closePaymentInfoViewButtonClick:)]) {
        [self.delegate closePaymentInfoViewButtonClick:sender];
    }
}

/*** 支付宝支付 ***/
- (IBAction)alipayPaymentButtonClick:(UIButton *)sender
{
    self.weChatBtn.selected = NO;
    self.alipayBtn.selected = YES;
    
    self.alipayBtn.layer.borderWidth = 2;
    self.alipayBtn.layer.borderColor = NDColor(69, 133, 245).CGColor;
    
    self.weChatBtn.layer.borderWidth = 1;
    self.weChatBtn.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.5].CGColor;
}

/*** 微信支付 ***/
- (IBAction)weChatPaymentButtonClick:(UIButton *)sender
{
    self.alipayBtn.selected = NO;
    self.weChatBtn.selected = YES;
    
    self.alipayBtn.layer.borderWidth = 1;
    self.alipayBtn.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.5].CGColor;
    
    self.weChatBtn.layer.borderWidth = 2;
    self.weChatBtn.layer.borderColor = NDColor(69, 133, 245).CGColor;
}

/*** 确认支付 ***/
- (IBAction)countersignPaymentButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(countersignPaymentButtonClick:paymentManner:)]) {
        [self.delegate countersignPaymentButtonClick:sender paymentManner:self.weChatBtn.selected];
    }
}

@end
