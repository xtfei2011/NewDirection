//
//  NDMineViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDMineViewController.h"
#import "NDClassifyView.h"
#import "NDNavigationController.h"
#import "NDLoginViewController.h"
#import "NDInformationController.h"

@interface NDMineViewController ()
/*** 头像 ***/
@property (weak, nonatomic) IBOutlet UIImageView *headView;
/*** 登录·注册 ***/
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
/*** 专业方向 ***/
@property (weak, nonatomic) IBOutlet UILabel *professionalLabel;
/*** 昵称 ***/
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@end

@implementation NDMineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self xtfei_setNavBarBackgroundAlpha:0.0f];
    
    [self setupClassifyView];

    UIButton *moreBtn = [UIButton createButtonWithTitle:@"完善信息" titleColor:[UIColor grayColor] imageName:@"common_icon_arrow" target:self action:@selector(perfectInformationButtonClick)];
    moreBtn.frame = CGRectMake(self.view.xtfei_width - 100, NDNavigationBarH, 90, 30);
    [self.view addSubview:moreBtn];
}

- (void)perfectInformationButtonClick
{
    NDInformationController *information = [[NDInformationController alloc] init];
    
    [self.navigationController pushViewController:information animated:YES];
}

- (void)setupClassifyView
{
    NDClassifyView *classifyView = [NDClassifyView viewFromXib];
    [self.view addSubview:classifyView];
}

- (IBAction)loginButtonClick:(UIButton *)sender
{
    NDLoginViewController *loginVC = [[NDLoginViewController alloc] init];
    NDNavigationController *nav = [[NDNavigationController alloc] initWithRootViewController:loginVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}
@end
