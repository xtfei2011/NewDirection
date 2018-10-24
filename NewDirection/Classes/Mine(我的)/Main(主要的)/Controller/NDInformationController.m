//
//  NDInformationController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDInformationController.h"
#import "NDDomainController.h"

@interface NDInformationController ()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *professionalLabel;
@end

@implementation NDInformationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"完善信息";
}

- (IBAction)replaceHeadButtonClick:(UIButton *)sender
{
    [TFProgressHUD showInfoMsg:@"更换头像"];
}

- (IBAction)professionalButtonClick:(UIButton *)sender
{
    NDDomainController *domainVC = [[NDDomainController alloc] init];
    domainVC.signature = ^(NSString * _Nonnull text) {
        self.professionalLabel.text = text;
    };
    [self.navigationController pushViewController:domainVC animated:YES];
}

- (IBAction)changePasswordButtonClick:(UIButton *)sender
{
    [TFProgressHUD showInfoMsg:@"修改密码"];
}

@end
