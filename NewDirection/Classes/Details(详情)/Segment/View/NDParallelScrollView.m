//
//  NDParallelScrollView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDParallelScrollView.h"
#import "NDParallelContentView.h"
#import "NDSegmentParam.h"
#import "NDSegmentView.h"

@interface NDParallelScrollView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) NDSegmentView *segmentView;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) NSArray<NDParallelContentView *> *contentViews;

@property (nonatomic ,strong) NDParallelParam *parallelParam;

@end

@implementation NDParallelScrollView

#pragma mark ===== 懒加载
- (NDSegmentView *)segmentView
{
    if (_segmentView == nil) {
        _segmentView = [[NDSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.xtfei_width, self.parallelParam.headerHeight) segmentParam:self.parallelParam.segmentParam];
        
        __weak NDParallelScrollView *weakSelf = self;
        _segmentView.selectedIndexBlock = ^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(index * weakSelf.scrollView.xtfei_width , 0) animated:YES];
        };
        [self addSubview:_segmentView];
    }
    return _segmentView;
}

- (instancetype)initWithFrame:(CGRect)frame contentViews:(NSArray<NDParallelContentView *> *)contentViews parallelParam:(NDParallelParam *)parallelParam
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.parallelParam = parallelParam;
        
        if (parallelParam.segmentParam.startIndex >= contentViews.count) {
            parallelParam.segmentParam.startIndex = 0;
        }
        self.currenIndex = parallelParam.segmentParam.startIndex;
        self.contentViews = contentViews;
        
        NSMutableArray *titles = [NSMutableArray array];
        
        for (int i = 0; i < _contentViews.count; ++i) {
            
            _contentViews[i].index = i;
            
            NSString *title = _contentViews[i].title;
            
            [titles addObject:(title == nil ? [NSString stringWithFormat:@"%d",i] : title)];
            
            _contentViews[i].frame = CGRectMake(i * self.scrollView.xtfei_width, 0, self.scrollView.xtfei_width, self.scrollView.xtfei_height);
            [self.scrollView addSubview:_contentViews[i]];
            
            if (i == parallelParam.segmentParam.startIndex) {
                [_contentViews[i] refreshContentView];
            }
        }
        self.scrollView.contentSize = CGSizeMake(_contentViews.count * self.scrollView.xtfei_width, 0);
        
        [self.segmentView reloadDataArray:titles];
        [self.segmentView setAssociatedScroll];
        
        if (parallelParam.segmentParam.startIndex > 0) {
            [self.scrollView setContentOffset:CGPointMake(parallelParam.segmentParam.startIndex * self.scrollView.xtfei_width , 0) animated:NO];
        }
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.parallelParam.headerHeight, self.xtfei_width, self.xtfei_height - self.parallelParam.headerHeight)];
        _scrollView.pagingEnabled = YES;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.segmentView.associatedScrollBlock) {
        self.segmentView.associatedScrollBlock(scrollView);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self dealWithScroll];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self dealWithScroll];
}

- (void)dealWithScroll
{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.xtfei_width;
    NDParallelContentView *view = [self.contentViews objectAtIndex:index];
    [view refreshContentView];
    
    [self.segmentView selectIndex:index animated:false];
    self.currenIndex = index;
}

@end
