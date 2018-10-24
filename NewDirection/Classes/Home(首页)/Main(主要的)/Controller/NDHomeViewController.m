//
//  NDHomeViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDHomeViewController.h"
#import "UIImage+TFImageHelper.h"
#import "NDSearchButton.h"
#import "NDSortView.h"
#import "NDSearchViewController.h"
#import "NDBanner.h"
#import "NDNoticeViewCell.h"
#import "NDSectionHeaderView.h"
#import "NDLiveViewCell.h"
#import "NDRecommendViewCell.h"
#import "NDMaterialViewCell.h"
#import "NDMessageViewController.h"
#import "NDDomainController.h"
#import "NDAdvert.h"
#import "NDDetailsController.h"
#import "NDCrossShakeDetailController.h"
#import "NDSegmentController.h"

#define Navbar_Colorchange_Point      (-ScrollViewHeight + NDNavigationBarH)
#define Limit_Offset_Y                 -(ScrollViewHeight + 70)

@interface NDHomeViewController ()
@property (nonatomic ,strong) NDSearchButton *searchBtn;
@property (nonatomic ,strong) NSMutableArray<NDBanner *> *banner;
@property (nonatomic ,strong) NSMutableArray<NDAdvert *> *advert;
@property (nonatomic ,strong) NSMutableArray<NDComment *> *comment;
@property (nonatomic ,strong) NSMutableArray<NDComment *> *course;
@property (nonatomic ,strong) NDSortView *sortView;
/*** 专业方向 ***/
@property (nonatomic ,strong) UIButton *domainBtn;
@end

@implementation NDHomeViewController

- (NDSearchButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [[NDSearchButton alloc] initWithFrame:CGRectMake(80, 0, NDMainScreen_Width - 160, 30)];
    }
    return _searchBtn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /*** 获取专业 ***/
    NSString *major = [NDUSER_DEFAULTS objectForKey:@"major"];
    
    [self leftButton:major];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupNavItems];
    
    /*** 加载顶部 Banner 视图 ***/
    [self.tableView addSubview:self.sortView];
    [self loadDataSource];
}

/*** 设置左边专业按钮 ***/
- (void)leftButton:(NSString *)title
{
    if (!title) {
        [self domainSelectButtonClick];
        return;
    }
    
    self.domainBtn = [UIButton createButtonWithTitle:title titleColor:[UIColor whiteColor] imageName:@"downward" target:self action:@selector(domainSelectButtonClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.domainBtn];
}

#pragma MARK ===== 模拟数据
- (void)loadDataSource
{
    self.banner = [NDBanner mj_objectArrayWithFilename:@"Banner.plist"];
    self.advert = [NDAdvert mj_objectArrayWithFilename:@"Advert.plist"];
    self.comment = [NDComment mj_objectArrayWithFilename:@"Books.plist"];
    
    self.course = [NDComment mj_objectArrayWithFilename:@"Course.plist"];
}

- (void)setupNavItems
{
    self.navigationItem.titleView = self.searchBtn;
    [self.searchBtn addTarget:self action:@selector(jumpSearchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

/*** 导航栏左边按钮 ***/
- (void)domainSelectButtonClick
{
    NDDomainController *domainVC = [[NDDomainController alloc] init];
    domainVC.signature = ^(NSString *text) {
        [self leftButton:text];
    };
    [self.navigationController pushViewController:domainVC animated:YES];
}

/*** 跳转搜索 ***/
- (void)jumpSearchButtonClick:(UIButton *)sender
{
    NDSearchViewController *searchVC = [[NDSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

/*** 右边消息按钮点击 ***/
- (void)subscribeButtonClick
{
    NDMessageViewController *messageVC = [[NDMessageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

#pragma mark ===== 导航栏渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < -ScrollViewHeight) {
        [self updateNavBarButtonItemsAlphaAnimated:.0f];
        
    } else {
        [self updateNavBarButtonItemsAlphaAnimated:1.0f];
    }
    
    if (offsetY > Navbar_Colorchange_Point) {
        
        /*** 右边消息按钮 ***/
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_home_message_selected" highImage:nil target:self action:@selector(subscribeButtonClick)];
        
        [self xtfei_setStatusBarStyle:UIStatusBarStyleDefault];
        CGFloat alpha = (offsetY - Navbar_Colorchange_Point) / NDNavigationBarH;
        [self xtfei_setNavBarBackgroundAlpha:alpha];
        [self updateSearchBarColor:alpha];
        
    } else {
        [self xtfei_setNavBarBackgroundAlpha:0.2];
        [self xtfei_setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.domainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        /*** 右边消息按钮 ***/
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_home_message" highImage:nil target:self action:@selector(subscribeButtonClick)];
    }
    
    /*** 限制下拉的距离 ***/
    if (offsetY < Limit_Offset_Y) {
        [scrollView setContentOffset:CGPointMake(0, Limit_Offset_Y)];
    }
}

- (void)updateNavBarButtonItemsAlphaAnimated:(CGFloat)alpha
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.navigationController.navigationBar xtfei_setBarButtonItemsAlpha:alpha hasSystemBackIndicator:NO];
    }];
}

- (void)updateSearchBarColor:(CGFloat)alpha
{
    UIImage *searchBgImage = [UIImage imageWithColor:[UIColor whiteColor]];
    searchBgImage = [searchBgImage xtfei_updateImageWithTintColor:NDColor(247, 247, 247) alpha:alpha];
    
    UIImage *searchImage = [UIImage imageNamed:@"nav_search"];
    searchImage = [searchImage xtfei_updateImageWithTintColor:NDColor(80, 85, 101) alpha:alpha];
    
    UIImage *leftImage = [UIImage imageNamed:@"downward"];
    leftImage = [leftImage xtfei_updateImageWithTintColor:NDColor(80, 85, 101) alpha:alpha];
    
    [self.domainBtn setTitleColor:NDColor(80, 85, 101) forState:UIControlStateNormal];
    [self.domainBtn setImage:leftImage forState:UIControlStateNormal];
    [self.searchBtn setBackgroundImage:searchBgImage forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:NDColor(80, 85, 101) forState:UIControlStateNormal];
    [self.searchBtn setImage:searchImage forState:UIControlStateNormal];
}

#pragma MARK ===== 轮播部分
- (NDSortView *)sortView
{
    if (!_sortView) {
        _sortView = [[NDSortView alloc] initWithFrame:CGRectMake(0, -ScrollViewHeight, NDMainScreen_Width, ScrollViewHeight)];
    }
    return _sortView;
}

- (void)setBanner:(NSMutableArray<NDBanner *> *)banner
{
    _banner = banner;

    self.sortView.banner = self.banner;
    
    [self.tableView reloadData];
}

#pragma mark ===== TableView 部分
- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(ScrollViewHeight - [self navBarBottom], 0, 0, 0);
    
    [self xtfei_setNavBarBackgroundAlpha:0.2];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    } else if (section == 2) {
        return self.course.count;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section > 0) ? 44 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NDSectionHeaderView *sectionHeaderView = [NDSectionHeaderView viewFromXib];
    sectionHeaderView.section = section;
    return sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NDMainScreen_Width, 10)];
    return sectionFooterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NDNoticeViewCell *cell = [NDNoticeViewCell cellWithTableView:tableView];
        cell.advert = self.advert;
        return cell;
        
    } else if (indexPath.section == 1) {
        NDLiveViewCell *cell = [NDLiveViewCell cellWithTableView:tableView];
        return cell;
        
    } else if (indexPath.section == 2) {
        NDRecommendViewCell *cell = [NDRecommendViewCell cellWithTableView:tableView];
        cell.course = self.course[indexPath.row];
        return cell;
        
    } else {
        NDMaterialViewCell *cell = [NDMaterialViewCell cellWithTableView:tableView];
        cell.comment = self.comment;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        return 9 * NDMainScreen_Width / 31;
    }
    return (NDMainScreen_Width - 5) / 3 * 1.4 + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        NDCrossShakeDetailController *crossShakeDetailVC = [[NDCrossShakeDetailController alloc] init];
        [self.navigationController pushViewController:crossShakeDetailVC animated:YES];
    } else if (indexPath.section == 2) {
        NDSegmentController *segmentVC = [[NDSegmentController alloc] init];
        [self.navigationController pushViewController:segmentVC animated:YES];
    } else {
        NDDetailsController *detailsVC = [[NDDetailsController alloc] init];
        detailsVC.type = 0;
        detailsVC.comment = self.comment[indexPath.row];
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
}

- (int)navBarBottom
{
    if ([TFNavigationBar isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}
@end
