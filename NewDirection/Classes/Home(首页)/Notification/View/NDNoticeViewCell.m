//
//  NDNoticeViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/25.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDNoticeViewCell.h"
#import "NDAdvertView.h"
#import "NDNotificationController.h"
#import "NDTabBarController.h"
#import "NDNavigationController.h"

@interface NDNoticeViewCell ()
@property (nonatomic ,strong) NDAdvertView *informView;
@end

@implementation NDNoticeViewCell
static NSString *const cellID = @"NDNoticeViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDNoticeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDNoticeViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.informView = [[NDAdvertView alloc] initWithFrame:CGRectMake(50, 5, NDMainScreen_Width - 110, 50)];
    [self.contentView addSubview:self.informView];
}

- (void)setAdvert:(NSMutableArray<NDAdvert *> *)advert
{
    _advert = advert;
    
    self.informView.advert = advert;
}

- (IBAction)completeButtonClick:(UIButton *)sender
{
    NDLog(@"更多···");
    /*** 获得 首页 模块对应的导航控制器 ***/
    NDTabBarController *tabBar = (NDTabBarController *)self.window.rootViewController;
    NDNavigationController *nav = tabBar.selectedViewController;
    
    NDNotificationController *notificationVC = [[NDNotificationController alloc] init];
    
    [nav pushViewController:notificationVC animated:YES];
}

@end
