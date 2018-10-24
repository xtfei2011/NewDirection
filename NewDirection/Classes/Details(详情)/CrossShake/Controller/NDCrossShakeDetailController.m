//
//  NDCrossShakeDetailController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/18.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import "NDCrossShakeDetailController.h"
#import "NDSegmentParam.h"
#import "NDVerticalScrollView.h"
#import "NDParallelContentView.h"
#import "NDCrossShakeDetailHeadView.h"
#import "NDLeftWebView.h"
#import "NDRightTableView.h"

@interface NDCrossShakeDetailController ()
@property (nonatomic ,strong) NDVerticalScrollView *verticalScrollView;
@property (nonatomic ,strong) NDCrossShakeDetailHeadView *headView;
@end

@implementation NDCrossShakeDetailController

#pragma mark === 懒加载
- (NDVerticalScrollView *)verticalScrollView
{
    if (_verticalScrollView == nil) {
        
        NDParallelContentView *detail = [[NDLeftWebView alloc] initWithSegmentTitle:@"详情"];
        NDParallelContentView *catalog = [[NDRightTableView alloc] initWithSegmentTitle:@"回放/预告"];
        
        NSArray *vc = @[detail ,catalog];
        
        NDVerticalParam *param = [[NDVerticalParam alloc] init];
        param.parallelParam.segmentParam.startIndex = 0;
        param.parallelParam.headerHeight = 40;
        param.offset_Y = NDNavigationBarH;
        
        _verticalScrollView = [[NDVerticalScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.xtfei_width, self.view.xtfei_height) headerView:self.headView contentViews:vc verticalParam:param];
        
        __weak NDCrossShakeDetailController *weakSelf = self;
        
        _verticalScrollView.didScrollBlock = ^(CGFloat dy) {
            [weakSelf didScroll:dy];
        };
        [self.view addSubview:_verticalScrollView];
    }
    return _verticalScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"直播间详情";
    
    [self verticalScrollView];
    
    if (@available(iOS 11.0, *)) {
        [self.verticalScrollView scrollView].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didScroll:(CGFloat)dy
{
    CGRect rect = self.headView.bounds;
    if (dy < 0) {rect.size.height -= dy;}
    self.headView.imageView.bounds = rect;
}

- (NDCrossShakeDetailHeadView *)headView
{
    if (_headView == nil) {
        _headView = [NDCrossShakeDetailHeadView viewFromXib];
        _headView.frame = CGRectMake(0, 0, NDMainScreen_Width, 470);
    }
    return _headView;
}

- (void)dealloc
{
    
}

@end
