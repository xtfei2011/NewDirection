//
//  NDCommentController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCommentController.h"
#import "NDCourseViewCell.h"
#import "NDCultivateViewCell.h"
#import "NDBooksViewCell.h"
#import "NDStoreTopView.h"
#import "NDDetailsController.h"
#import "NDSegmentController.h"

@interface NDCommentController ()
/*** 头部视图 ***/
@property (nonatomic ,strong) NDStoreTopView *storeTopView;
@property (nonatomic ,strong) NSMutableArray<NDComment *> *comment;
@end

@implementation NDCommentController
/** cell的重用标识 */
static NSString * const NDCourseID = @"NDCourseViewCell";
static NSString * const NDCultivateID = @"NDCultivateViewCell";
static NSString * const NDBooksID = @"NDBooksViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTabelView];
    [self loadDataSource];
}

/*** 加载头部视图 ***/
- (void)setupHeaderView:(NSString *)imageName
{
    self.storeTopView = [NDStoreTopView viewFromXib];
    self.storeTopView.xtfei_height = NDMainScreen_Width * 0.2;
    self.storeTopView.backgroundImage.image = [UIImage imageNamed:imageName];
    self.tableView.tableHeaderView = self.storeTopView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT, 0);
}

- (void)setupTabelView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT + 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
    if (self.type == NDSegmentedTypeCourse) {
        self.tableView.rowHeight = 9 * NDMainScreen_Width / 31;
        // 在线课程
    } else if (self.type == NDSegmentedTypeCultivate) {
        self.tableView.rowHeight = 9 * NDMainScreen_Width / 31;
        // 面授培训
    } else {
        self.tableView.rowHeight = 21 * NDMainScreen_Width / 62;
        // 图书资料
    }
}

#pragma MARK ===== 模拟数据
- (void)loadDataSource
{
    if (self.type == NDSegmentedTypeCourse) {
        self.comment = [NDComment mj_objectArrayWithFilename:@"Course.plist"];
    } else if (self.type == NDSegmentedTypeCultivate) {
        self.comment = [NDComment mj_objectArrayWithFilename:@"Cultivate.plist"];
    } else {
        self.comment = [NDComment mj_objectArrayWithFilename:@"Books.plist"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comment.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == NDSegmentedTypeCourse) {
        NDCourseViewCell *cell = [NDCourseViewCell cellWithTableView:tableView];
        cell.comment = self.comment[indexPath.row];
        return cell;
        
    } else if (self.type == NDSegmentedTypeCultivate) {
        NDCultivateViewCell *cell = [NDCultivateViewCell cellWithTableView:tableView];
        cell.comment = self.comment[indexPath.row];
        return cell;
        
    } else {
        NDBooksViewCell *cell = [NDBooksViewCell cellWithTableView:tableView];
        cell.comment = self.comment[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.type == NDSegmentedTypeCourse) {
        NDSegmentController *segmentVC = [[NDSegmentController alloc] init];
        
        [self.navigationController pushViewController:segmentVC animated:YES];
        NDLog(@"开发中···");
    } else {
        NDDetailsController *detailsVC = [[NDDetailsController alloc] init];
        detailsVC.type = self.type;
        detailsVC.comment = self.comment[indexPath.row];
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
}
@end
