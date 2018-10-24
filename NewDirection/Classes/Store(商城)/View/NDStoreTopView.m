//
//  NDStoreTopView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDStoreTopView.h"
#import "NDStoreViewController.h"
#import "NDDomainController.h"

@interface NDStoreTopView ()
@property (weak, nonatomic) IBOutlet UILabel *domainLabel;

@end

@implementation NDStoreTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    /*** 获取专业 ***/
    NSString *major = [NDUSER_DEFAULTS objectForKey:@"major"];
    self.domainLabel.text = major;
    
    self.xtfei_height = NDMainScreen_Width *0.2;
}

- (IBAction)domainChooseButtonClick:(UIButton *)sender
{
    NDStoreViewController *storeVC = (NDStoreViewController *)[sender currentViewController];
    NDDomainController *domainVC = [[NDDomainController alloc] init];
    domainVC.signature = ^(NSString *text) {
        self.domainLabel.text = text;
    };
    [storeVC.navigationController pushViewController:domainVC animated:YES];
}

@end
