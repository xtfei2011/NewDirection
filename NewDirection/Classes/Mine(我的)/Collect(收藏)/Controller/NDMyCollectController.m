//
//  NDMyCollectController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDMyCollectController.h"
#import "NDTitleButton.h"

@interface NDMyCollectController ()<UIScrollViewDelegate>
/** 当前选中的标题按钮 */
@property (nonatomic ,weak) NDTitleButton *selectedTitleButton;
/** 标题按钮底部的指示器 */
@property (nonatomic ,weak) UIView *indicatorView;
/** UIScrollView */
@property (nonatomic ,weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic ,weak) UIView *titlesView;

@property (nonatomic ,strong) NSArray *titles;
@end

@implementation NDMyCollectController

static CGFloat const SegmentationH = 45;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    
    [self setupChildViewControllers];
    [self setupScrollView];
    [self setupTitlesView];
    // 默认添加子控制器的view
    [self addChildVcView];
}

- (void)setupChildViewControllers
{
    self.titles = @[@"课程" ,@"直播" ,@"面授" ,@"图书"];
    
    for (int i = 0; i < self.titles.count; i ++) {
        
        UIViewController *viewClass = [[NSClassFromString(MyCollectChildController[i]) alloc] init];
        
        if (i != 1) {
            [viewClass setValue:@NO forKey:@"isUpload"];
        }
        [self addChildViewController:viewClass];
    }
}

- (void)setupScrollView
{
    CGFloat scrollViewH = NDNavigationBarH + SegmentationH;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = NDCommonBgColor;
    scrollView.frame = CGRectMake(0, scrollViewH + 0.5, self.view.xtfei_width, self.view.xtfei_height - scrollViewH);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    // 添加所有子控制器的view到scrollView中
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.xtfei_width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupTitlesView
{
    // 标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.frame = CGRectMake(0, NDNavigationBarH, self.view.xtfei_width, SegmentationH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加标题
    NSArray *titles = self.titles;
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.xtfei_width * (count/2)/3 / count;
    CGFloat titleButtonH = titlesView.xtfei_height;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 创建
        NDTitleButton *titleButton = [NDTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton setImage:nil forState:UIControlStateNormal];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
    }
    
    // 按钮的选中颜色
    NDTitleButton *firstTitleButton = titlesView.subviews.firstObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.xtfei_height = 1;
    indicatorView.xtfei_y = titlesView.xtfei_height - indicatorView.xtfei_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.xtfei_width = firstTitleButton.titleLabel.xtfei_width;
    indicatorView.xtfei_centerX = firstTitleButton.xtfei_centerX;
    
    // 默认情况 : 选中最前面的标题按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
}

- (void)setupNav
{
    self.view.backgroundColor = NDCommonBgColor;
}

#pragma mark - 监听点击
- (void)titleClick:(NDTitleButton *)titleButton
{
    // 某个标题按钮被重复点击
    if (titleButton == self.selectedTitleButton) return;
    
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.xtfei_width = titleButton.titleLabel.xtfei_width;
        self.indicatorView.xtfei_centerX = titleButton.xtfei_centerX;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.xtfei_width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.xtfei_width;
    
    UIViewController *childVc = self.childViewControllers[index];
    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.xtfei_width;
    NDTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleClick:titleButton];
    
    [self addChildVcView];
}

@end
