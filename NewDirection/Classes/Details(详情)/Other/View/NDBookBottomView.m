//
//  NDBookBottomView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/18.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import "NDBookBottomView.h"
#import "NDDetailsController.h"
#import "NDConsultViewController.h"

@implementation NDBookBottomView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, NDMainScreen_Height - 44 - iPhoneX_BOTTOM_HEIGHT, NDMainScreen_Width, 44 + iPhoneX_BOTTOM_HEIGHT);
}

/*** 电话咨询 ***/
- (IBAction)phoneCallTaskButtonClick:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ServicePhone]];
}

/*** 线上咨询 ***/
- (IBAction)liveTaskButtonClick:(UIButton *)sender
{
    NDDetailsController *detailsVC = (NDDetailsController *)[sender currentViewController];
    NDConsultViewController *consultVC = [[NDConsultViewController alloc] init];
    consultVC.navigationItem.title = @"咨询";
    [detailsVC.navigationController pushViewController:consultVC animated:YES];
}


@end
