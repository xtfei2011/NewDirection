//
//  NDProclamationController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDProclamationController.h"
#import "NDProclamationCell.h"

@interface NDProclamationController ()

@end

@implementation NDProclamationController

/** cell的重用标识 */
static NSString * const NDProclamationID = @"NDProclamationController";

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationItem.title = @"勘误公告";
    
    [self setupTabelView];
}

- (void)setupTabelView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NDProclamationCell class]) bundle:nil] forCellReuseIdentifier:NDProclamationID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDProclamationCell *cell = [NDProclamationCell cellWithTableView:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
@end
