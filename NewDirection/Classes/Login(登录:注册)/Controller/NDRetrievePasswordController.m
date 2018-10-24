//
//  NDRetrievePasswordController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDRetrievePasswordController.h"
#import "NDTextField.h"

@interface NDRetrievePasswordController ()
@property (weak, nonatomic) IBOutlet NDTextField *mobileField;
@property (weak, nonatomic) IBOutlet NDTextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *verificationView;

@end

@implementation NDRetrievePasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"找回密码(1/2)";
}

- (IBAction)nextStepButtonClick:(UIButton *)sender
{
    
}


@end
