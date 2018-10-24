//
//  NDNotificationController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDNotificationController.h"
#import "NDNotificationViewCell.h"
#import "TFWebViewController.h"

@interface NDNotificationController ()
@property (nonatomic ,strong) NSMutableArray<NDAdvert *> *advert;
@end

@implementation NDNotificationController
/** cell的重用标识 */
static NSString * const NDNotificationID = @"NDNotificationViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"考务动态";
    
    [self setupTabelView];
    [self loadDataSource];
}

#pragma MARK ===== 模拟数据
- (void)loadDataSource
{
    self.advert = [NDAdvert mj_objectArrayWithFilename:@"Dynamic.plist"];
}

- (void)setupTabelView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NDNotificationViewCell class]) bundle:nil] forCellReuseIdentifier:NDNotificationID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.advert.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDNotificationViewCell *cell = [NDNotificationViewCell cellWithTableView:tableView];
    cell.advert = self.advert[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TFWebViewController *webView = [[TFWebViewController alloc] init];
    [webView loadWebURLString:self.advert[indexPath.row].url];
    
    [self.navigationController pushViewController:webView animated:YES];
}

@end
