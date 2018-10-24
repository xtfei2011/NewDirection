//
//  NDRegisteredViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDRegisteredViewController.h"
#import "NDTextField.h"
#import "NDCountDownButton.h"

@interface NDRegisteredViewController ()
/*** 手机号 ***/
@property (weak, nonatomic) IBOutlet NDTextField *mobileField;
/*** 验证码 ***/
@property (weak, nonatomic) IBOutlet NDTextField *verificationField;
/*** 密码 ***/
@property (weak, nonatomic) IBOutlet NDTextField *passwordField;
/*** 倒计时容器 ***/
@property (weak, nonatomic) IBOutlet UIView *verificationView;
/*** 邀请码 ***/
@property (weak, nonatomic) IBOutlet NDTextField *invitationField;
/*** 获取验证码按钮 ***/
@property (nonatomic ,strong) NDCountDownButton *countDownBtn;
/*** 是否同意协议 ***/
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation NDRegisteredViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册账号";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupAcquireVerificationBtn];
}

- (void)setupAcquireVerificationBtn
{
    self.countDownBtn = [[NDCountDownButton alloc] initWithFrame:self.verificationView.bounds];
    self.countDownBtn.originalColor = [UIColor darkGrayColor];
    self.countDownBtn.processColor = NDColor(83, 134, 237);
    
    [self.countDownBtn addTarget:self action:@selector(acquireVerificationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.verificationView addSubview:self.countDownBtn];
}

- (void)acquireVerificationBtnClick
{
    if (![self.mobileField.text isValidateMobile]) {
        
        NDLog(@"--->手机号输入有误");
    } else {
        NDLog(@"--->发送验证码成功");
        
    }
}

- (IBAction)agreedButtonClick:(UIButton *)sender
{
    self.confirmBtn.selected = !self.confirmBtn.selected;
    if (self.confirmBtn.selected) {
        [self.confirmBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    } else {
        [self.confirmBtn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    }
}

/*** 用户协议 ***/
- (IBAction)agreementButtonClick:(UIButton *)sender
{
    NDLog(@"--->用户协议");
}

/*** 注册 ***/
- (IBAction)registeredButtonClick:(UIButton *)sender
{
    NDLog(@"--->正在注册");
}

@end
