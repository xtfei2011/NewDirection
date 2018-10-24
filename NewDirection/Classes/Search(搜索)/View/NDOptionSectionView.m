//
//  NDOptionSectionView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDOptionSectionView.h"
#import "NDCourseViewController.h"
#import "NDBooksViewController.h"
#import "NDLiveViewController.h"
#import "NDNotificationController.h"
#import "NDOptionViewController.h"

@interface NDOptionSectionView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation NDOptionSectionView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setOption:(NDOption *)option
{
    _option = option;
    
    self.titleLabel.text = option.theme;
}

- (IBAction)moreButtonClick:(UIButton *)sender
{
    NDOptionViewController *optionVC = (NDOptionViewController *)[sender currentViewController];
    
    if ([self.titleLabel.text isEqualToString:@"在线课程"]) {
        NDCourseViewController *courseVC = [[NDCourseViewController alloc] init];
        [optionVC.navigationController
         pushViewController:courseVC animated:YES];
        
    } else if ([self.titleLabel.text isEqualToString:@"直播"]) {
        NDLiveViewController *liveVC = [[NDLiveViewController alloc] init];
        [optionVC.navigationController pushViewController:liveVC animated:YES];
        
    } else if ([self.titleLabel.text isEqualToString:@"图书"]) {
        NDBooksViewController *booksVC = [[NDBooksViewController alloc] init];
        [optionVC.navigationController pushViewController:booksVC animated:YES];
        
    } else {
        NDNotificationController *notificationVC = [[NDNotificationController alloc] init];
        [optionVC.navigationController pushViewController:notificationVC animated:YES];
    }
}
@end
