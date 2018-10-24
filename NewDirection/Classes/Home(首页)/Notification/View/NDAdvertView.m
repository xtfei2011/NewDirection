//
//  NDAdvertView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/25.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDAdvertView.h"
#import "NDAdvertViewCell.h"
#import "NDTabBarController.h"
#import "NDNavigationController.h"
#import "TFWebViewController.h"

@interface NDAdvertView ()<UITableViewDelegate, UITableViewDataSource>
/*** 滚动视图 ***/
@property (nonatomic ,strong) UITableView *noticeView;
/*** 定时器 ***/
@property (nonatomic ,strong) NSTimer *timer;
@end

@implementation NDAdvertView

/*** 懒加载 noticeView ***/
- (UITableView *)noticeView
{
    if (!_noticeView) {
        
        _noticeView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _noticeView.sectionFooterHeight = 0;
        _noticeView.sectionHeaderHeight = 0;
        _noticeView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _noticeView.rowHeight = 25;
        _noticeView.delegate = self;
        _noticeView.dataSource = self;
        _noticeView.showsHorizontalScrollIndicator = NO;
        _noticeView.showsVerticalScrollIndicator = NO;
        _noticeView.scrollEnabled = NO;
        _noticeView.pagingEnabled = YES;
        _noticeView.backgroundColor = [UIColor clearColor];
        
        [_noticeView registerClass:[NDAdvertViewCell class] forCellReuseIdentifier:@"cell"];
        _noticeView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_noticeView];
    }
    return _noticeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.noticeView.frame = self.bounds;
}

- (void)setAdvert:(NSMutableArray<NDAdvert *> *)advert
{
    _advert = advert;
    
    if (advert == nil) {
        [self removeTimer];
        return;
    }
    if (advert.count == 1) {
        [self removeTimer];
    }
    [self.noticeView reloadData];
    [self.noticeView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [self addTimer];
}

- (NSIndexPath *)resetIndexPath
{
    /*** 当前正在展示的位置 ***/
    NSIndexPath *currentIndexPath = [[self.noticeView indexPathsForVisibleRows] lastObject];
    
    /*** 下一条展示的位置 ***/
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForRow:currentIndexPath.row inSection:3];
    [self.noticeView scrollToRowAtIndexPath:currentIndexPathReset atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    return currentIndexPathReset;
}

- (void)nextPage
{
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    /*** 计算下一条展示的位置 ***/
    NSInteger nextItem = currentIndexPathReset.row + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.advert.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextItem inSection:nextSection];
    
    /*** 动画滚动到下一条位置 ***/
    [self.noticeView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark ---------- UITableView DataSource && Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.advert.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDAdvertViewCell *cell = [NDAdvertViewCell cellWithTableView:tableView];
    cell.advert = self.advert[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    /*** 获得 首页 模块对应的导航控制器 ***/
    NDTabBarController *tabBar = (NDTabBarController *)self.window.rootViewController;
    NDNavigationController *nav = tabBar.selectedViewController;
    
    TFWebViewController *webView = [[TFWebViewController alloc] init];
    [webView loadWebURLString:self.advert[indexPath.row].url];
    [nav pushViewController:webView animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
@end
