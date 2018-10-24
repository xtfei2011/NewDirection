//
//  NDOptionViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDOptionViewController.h"
#import "NDOptionSectionView.h"
#import "NDCourseViewCell.h"
#import "NDPreviewLiveViewCell.h"
#import "NDBooksViewCell.h"
#import "NDNotificationViewCell.h"
#import "NDOption.h"

@interface NDOptionViewController ()
@property (nonatomic ,strong) NSMutableArray<NDOption *> *option;
@end

@implementation NDOptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    [self loadDataSource];
}

#pragma MARK ===== 模拟数据
- (void)loadDataSource
{
    self.option = [NDOption mj_objectArrayWithFilename:@"Option.plist"];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.option.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NDOption *option = self.option[section];
    return option.course.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NDOptionSectionView *sectionHeaderView = [NDOptionSectionView viewFromXib];
    sectionHeaderView.option = self.option[section];
    return sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NDMainScreen_Width, 1)];
    return sectionFooterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDOption *option = self.option[indexPath.section];
    if ([option.theme isEqualToString:@"在线课程"]) {
        NDCourseViewCell *cell = [NDCourseViewCell cellWithTableView:tableView];
        NDComment *comment = option.course[indexPath.row];
        cell.comment = comment;
        return cell;
        
    } else if ([option.theme isEqualToString:@"直播"]) {
        
        NDPreviewLiveViewCell *cell = [NDPreviewLiveViewCell cellWithTableView:tableView];
//        cell.comment = option.course[indexPath.row];
        return cell;
    } else if ([option.theme isEqualToString:@"图书"]) {
        
        NDBooksViewCell *cell = [NDBooksViewCell cellWithTableView:tableView];
        cell.comment = option.course[indexPath.row];
        return cell;
    } else {
        
        NDComment *comment = option.course[indexPath.row];
        NDNotificationViewCell *cell = [NDNotificationViewCell cellWithTableView:tableView];
        cell.advert = (NDAdvert *)comment;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 9 * NDMainScreen_Width / 31;
    } else if (indexPath.section == 1) {
        return 40 * NDMainScreen_Width / 121;
    } else if (indexPath.section == 2) {
        return 21 * NDMainScreen_Width / 62;
    } else {
        return 110;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
@end
