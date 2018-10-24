//
//  NDMyLocaleController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDMyLocaleController.h"
#import "NDCultivateViewCell.h"
#import "NDDetailsController.h"

@interface NDMyLocaleController ()
@property (nonatomic ,strong) NSMutableArray<NDComment *> *comment;
@end

@implementation NDMyLocaleController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的面授";

    [self setupTabelView];
    [self loadDataSource];
}

- (void)setupTabelView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT + 49, 0);
    self.tableView.rowHeight = 9 * NDMainScreen_Width / 31;
}

#pragma MARK ===== 模拟数据
- (void)loadDataSource
{
    self.comment = [NDComment mj_objectArrayWithFilename:@"Cultivate.plist"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comment.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDCultivateViewCell *cell = [NDCultivateViewCell cellWithTableView:tableView];
    cell.comment = self.comment[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NDDetailsController *detailsVC = [[NDDetailsController alloc] init];
    detailsVC.type = NDSegmentedTypeCultivate;
    detailsVC.comment = self.comment[indexPath.row];
    [self.navigationController pushViewController:detailsVC animated:YES];
}
@end
