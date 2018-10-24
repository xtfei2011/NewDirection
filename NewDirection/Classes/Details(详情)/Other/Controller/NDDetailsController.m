//
//  NDDetailsController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/7.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDDetailsController.h"
#import "NDDetailsViewCell.h"
#import "NDDetailsBottomView.h"
#import "NDBookBottomView.h"
#import "NDTitleScrollView.h"
#import "NDShareManager.h"

@interface NDDetailsController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong) NDTitleScrollView *titleScrollView;
@property (nonatomic ,strong) NDShareManager *shareView;
@end

@implementation NDDetailsController

- (NDTitleScrollView *)titleScrollView
{
    if (!_titleScrollView) {
        _titleScrollView = [[NDTitleScrollView alloc] initWithFrame:CGRectMake(60, 0, NDMainScreen_Width - 120, 30)];
        _titleScrollView.backgroundColor = [UIColor clearColor];
    }
    return _titleScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.titleScrollView;
    
    /*** 右边消息按钮 ***/
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_details_share" highImage:nil target:self action:@selector(shareButtonClick)];
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = NDCommonBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NDMainScreen_Width *0.56 + 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDDetailsViewCell *cell = [NDDetailsViewCell cellWithTableView:tableView];
    cell.type = self.type;
    cell.comment = self.comment;
    return cell;
}

- (void)setComment:(NDComment *)comment
{
    _comment = comment;
    
    self.titleScrollView.showContent = comment.title;
    
    if (self.type == NDSegmentedTypeMaterial) {
        NDBookBottomView *bookBottomView = [NDBookBottomView viewFromXib];
        [self.view addSubview:bookBottomView];
    } else {
        NDDetailsBottomView *bottomView = [NDDetailsBottomView viewFromXib];
        bottomView.type = self.type;
        bottomView.comment = comment;
        [self.view addSubview:bottomView];
    }
}

/*** 分享 ***/
- (void)shareButtonClick
{
    _shareView = [[NDShareManager alloc] init];
    
    [_shareView initWithShareViewController:self shareTitle:@"新方向教育" shareContent:@"读书有屁用" shareIcon:[UIImage imageNamed:@"AppIcon"] shareUrl:@"https://www.baidu.com"];
    
    [_shareView show];
}
@end
