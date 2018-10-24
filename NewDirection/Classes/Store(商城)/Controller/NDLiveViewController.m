//
//  NDLiveViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDLiveViewController.h"
#import "NDLiveHeaderView.h"
#import "NDPreviewLiveViewCell.h"
#import "NDCrossShakeViewCell.h"
#import "NDDetailsController.h"
#import "NDStoreTopView.h"
#import "NDPurchaseLiveController.h"

@interface NDLiveViewController ()
/*** 头部视图 ***/
@property (nonatomic ,strong) NDStoreTopView *storeTopView;
@property (nonatomic ,strong) NSMutableArray<NDComment *> *comment;
@end

@implementation NDLiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"直播教室";
    
    [self setupTableView];
    
    if (!self.isUpload) return;
    [self setupHeaderView:@"live_top"];
    
    [self loadDataSource];
}

/*** 加载头部视图 ***/
- (void)setupHeaderView:(NSString *)imageName
{
    self.storeTopView = [NDStoreTopView viewFromXib];
    self.storeTopView.xtfei_height = NDMainScreen_Width *0.2;
    self.storeTopView.backgroundImage.image = [UIImage imageNamed:imageName];
    self.tableView.tableHeaderView = self.storeTopView;
}

#pragma MARK ===== 模拟数据
- (void)loadDataSource
{
    self.comment = [NDComment mj_objectArrayWithFilename:@"Home_Recruitment.plist"];
    
    [self.tableView reloadData];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"已购直播" style:UIBarButtonItemStyleDone target:self action:@selector(clickLiveRoomButton)];
}

- (void)clickLiveRoomButton
{
    NDPurchaseLiveController *purchaseVC = [[NDPurchaseLiveController alloc] init];
    [self.navigationController pushViewController:purchaseVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? 5 : 1;
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
    NDLiveHeaderView *liveHeaderView = [NDLiveHeaderView viewFromXib];
    liveHeaderView.section = section;
    return liveHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NDMainScreen_Width, 0.1)];
    sectionFooterView.backgroundColor = [UIColor whiteColor];
    return sectionFooterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NDCrossShakeViewCell *cell = [NDCrossShakeViewCell cellWithTableView:tableView];
//        cell.comment = self.comment[indexPath.row];
        return cell;
        
    } else {
        NDPreviewLiveViewCell *cell = [NDPreviewLiveViewCell cellWithTableView:tableView];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (NDMainScreen_Width - 85) / 2 * 0.75 + 80;
        
    } else {
       
        return 40 * NDMainScreen_Width / 121;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NDDetailsController *detailsVC = [[NDDetailsController alloc] init];
    detailsVC.type = NDSegmentedTypeLive;
    detailsVC.comment = self.comment[indexPath.row];
    [self.navigationController pushViewController:detailsVC animated:YES];
}
@end
