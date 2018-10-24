//
//  NDVerticalScrollView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDVerticalScrollView.h"
#import "NDSegmentParam.h"
#import "NDParallelContentView.h"

@interface NDVerticalScrollView ()<UIScrollViewDelegate>

@property (nonatomic ,strong ,readwrite) NDParallelScrollView *parallelScrollView;
@property (nonatomic ,strong) NDGestureScrollView *gestureScrollView;
@property (nonatomic ,strong) NDVerticalParam *verticalParam;
@property (nonatomic ,strong) NSArray<NDParallelContentView *> *contentViews;
@property (nonatomic ,strong) NSMutableArray<UIScrollView *> *scrollArray;

@property (nonatomic ,strong) UIView *headView;
@property (nonatomic ,assign) BOOL isMark;
@property (nonatomic ,assign) CGFloat last_offsetY;
@property (nonatomic ,assign) BOOL nextReturn;
@property (nonatomic ,assign) CGFloat startH;
@end

@implementation NDVerticalScrollView

- (instancetype)initWithFrame:(CGRect)frame headerView:(UIView *)headerView contentViews:(NSArray<NDParallelContentView *> *)contentViews verticalParam:(NDVerticalParam *)verticalParam
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.headView = headerView;
        if (headerView == nil) {
            _headView = [[UIView alloc] init];
        }
        CGFloat headHeight = ceil(_headView.xtfei_height);
        
        _headView.frame = CGRectMake(0, 0, frame.size.width, headHeight);
        self.verticalParam = verticalParam;
        self.contentViews = contentViews;
        self.startH = _headView.xtfei_height - fabs(_verticalParam.offset_Y);
        
        [self parallelScrollView];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    return _gestureScrollView;
}

/*** 手势 ScrollView ****/
- (NDGestureScrollView *)gestureScrollView
{
    if (_gestureScrollView == nil) {
        
        _gestureScrollView = [[NDGestureScrollView alloc] initWithFrame:self.bounds];
        _gestureScrollView.showsVerticalScrollIndicator = NO;
        _gestureScrollView.delegate = self;
        _gestureScrollView.contentSize = CGSizeMake(0, self.xtfei_height + _startH);
        _gestureScrollView.viewArray = self.scrollArray;
        
        [self addSubview:_gestureScrollView];
    }
    return _gestureScrollView;
}

- (NSMutableArray<UIScrollView *> *)scrollArray
{
    if (_scrollArray == nil) {
        _scrollArray = [[NSMutableArray alloc] init];
    }
    return _scrollArray;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL show = NO;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= _startH) {
        scrollView.contentOffset = CGPointMake(0, _startH);
        _last_offsetY = scrollView.contentOffset.y;
        show = YES;
    }
    UIScrollView *currenScrollView = nil;
    for (UIScrollView *scroll in self.scrollArray) {
        if (scroll.tag == self.parallelScrollView.currenIndex) {
            currenScrollView = scroll;
            break;
        }
    }
    if (currenScrollView == nil) return;
    if (currenScrollView.contentOffset.y > 0 && (self.gestureScrollView.contentOffset.y < _startH) && !self.isMark) {
        scrollView.contentOffset = CGPointMake(0, _last_offsetY);
        show = YES;
    }
    _last_offsetY = scrollView.contentOffset.y;
    currenScrollView.showsVerticalScrollIndicator = show;
    if (self.didScrollBlock) {
        self.didScrollBlock(scrollView.contentOffset.y);
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview == nil) {
        for (UIScrollView *sc in _scrollArray) {
            [sc removeObserver:self forKeyPath:@"contentOffset"];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (_nextReturn) {
            _nextReturn = NO;
            return;
        }
        CGFloat new = [change[@"new"] CGPointValue].y;
        CGFloat old = [change[@"old"] CGPointValue].y;
        if (new == old) return;
        
        CGFloat oldHeight = new - old;
        if (oldHeight < 0) {
            if (((UIScrollView *)object).contentOffset.y < 0) {
                _nextReturn = YES;
                ((UIScrollView *)object).contentOffset = CGPointMake(0, 0);
            }
            self.isMark = NO;
        } else {
            if (self.gestureScrollView.contentOffset.y < _startH) {
                _nextReturn = YES;
                self.isMark = YES;
                ((UIScrollView *)object).contentOffset = CGPointMake(0, old);
            } else {
                self.isMark = NO;
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (NDParallelScrollView *)parallelScrollView
{
    if (_parallelScrollView == nil) {
        
        __weak NDVerticalScrollView *weakSelf = self;
        id block = ^(UIScrollView *scrollView,NSInteger index) {
            scrollView.tag = index;
            if (![weakSelf.scrollArray containsObject:scrollView]) {
                [weakSelf.scrollArray addObject:scrollView];
                [scrollView addObserver:weakSelf forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            }
        };
        for (NDParallelContentView *contentView in self.contentViews) {
            contentView.didAddScrollViewBlock = block;
        }
        _parallelScrollView = [[NDParallelScrollView alloc] initWithFrame:CGRectMake(0, self.headView.frame.size.height, self.xtfei_width, self.frame.size.height - fabs(_verticalParam.offset_Y)) contentViews:self.contentViews parallelParam:self.verticalParam.parallelParam];
        
        [self.gestureScrollView addSubview:_parallelScrollView];
        [self.gestureScrollView addSubview:_headView];
    }
    return _parallelScrollView;
}
@end


@implementation NDGestureScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([self.viewArray containsObject:otherGestureRecognizer.view]) {
        return YES;
    }
    return NO;
}
@end
