//
//  NDApplyViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/13.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDApplyViewController.h"
#import "NDTextField.h"
#import "NDTextView.h"
#import "NDPaymentView.h"

@interface NDApplyViewController ()
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet NDTextField *nameField;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet NDTextField *phoneField;
@property (weak, nonatomic) IBOutlet UIView *remarkView;
@property (weak, nonatomic) IBOutlet NDTextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UIButton *countersignBtn;
@property (weak, nonatomic) IBOutlet UIView *paidContentView;

@property (nonatomic ,strong) NDPaymentView *paymentView;
@end

@implementation NDApplyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"面授报名";
    
    [self setupApplyView];
}

- (void)setupApplyView
{
    
    self.paidContentView.hidden = (self.index == 1003) ? NO : YES;
    
    self.nameView.layer.borderWidth = 0.5;
    self.nameView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.phoneView.layer.borderWidth = self.nameView.layer.borderWidth;
    self.phoneView.layer.borderColor = self.nameView.layer.borderColor;
    
    self.remarkView.layer.borderWidth = self.nameView.layer.borderWidth;
    self.remarkView.layer.borderColor = self.nameView.layer.borderColor;
    
    self.remarkTextView.maxLength = 100;
    self.remarkTextView.placehoder = @"请输入其他备注信息···";
    
    [self.remarkTextView changeText:^(NDTextView *textView) {
        NDLog(@"--->%@",textView.text);
    }];
}

- (IBAction)countersignButtonClick:(UIButton *)sender
{
    if (self.index == 1003) {
        
        [self paymentButtonClick];
    } else {
        
    }
}

- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view endEditing:YES];
}

/*** 支付 ***/
- (void)paymentButtonClick
{
    self.paymentView = [[NDPaymentView alloc] initWithPaymentInfo:@"2019中医专长考前全真模拟卷2019中医专长考前全真模拟卷" paymentMoney:@"¥ 3000.00" paymentManner:0];
    
    [self.paymentView show];
}
@end
