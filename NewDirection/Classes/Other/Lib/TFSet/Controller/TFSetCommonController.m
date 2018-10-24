//
//  TFSetCommonController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "TFSetCommonController.h"
#import "TFSetCommonGroup.h"
#import "TFSetCommonItem.h"
#import "TFSetCommonCell.h"

@interface TFSetCommonController ()
@property (nonatomic ,strong) NSMutableArray *groups;
@end

@implementation TFSetCommonController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = NDCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0.1;
    self.tableView.rowHeight = 50;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TFSetCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFSetCommonCell *cell = [TFSetCommonCell cellWithTableView:tableView];
    TFSetCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    [cell setIndexPath:indexPath rowsInSection:(int)group.items.count];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    TFSetCommonGroup *group = self.groups[section];
    return group.footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    TFSetCommonGroup *group = self.groups[section];
    return [group.footer length] > 0 ? 45 : 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TFSetCommonGroup *group = self.groups[section];
    return group.header;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFSetCommonGroup *group = self.groups[indexPath.section];
    TFSetCommonItem *item = group.items[indexPath.row];
    
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    if (item.operation) {
        item.operation();
    }
}
@end
