//
//  NDLoginViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDLoginViewController.h"
#import "NDTextField.h"
#import "NDRegisteredViewController.h"
#import "NDRetrievePasswordController.h"

@interface NDLoginViewController ()
/*** 账号 ***/
@property (weak, nonatomic) IBOutlet NDTextField *accountField;
/*** 密码 ***/
@property (weak, nonatomic) IBOutlet NDTextField *passwordField;

@end

@implementation NDLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavItems];
}

- (void)setupNavItems
{
    self.navigationItem.title = @"登录";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"back_arrow" highImage:nil target:self action:@selector(leftBarButtonClick)];
}

- (void)leftBarButtonClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/*** 注册 ***/
- (IBAction)registeredButtonClick:(UIButton *)sender
{
    NDRegisteredViewController *registeredVC = [[NDRegisteredViewController alloc] init];
    [self.navigationController pushViewController:registeredVC animated:YES];
}

/*** 找回密码 ***/
- (IBAction)retrievePasswordButtonClick:(UIButton *)sender
{
    NDRetrievePasswordController *retrievePasswordVC = [[NDRetrievePasswordController alloc] init];
    [self.navigationController pushViewController:retrievePasswordVC animated:YES];
}

/*** 登录 ***/
- (IBAction)loginButtonClick:(UIButton *)sender
{
    
}

@end
