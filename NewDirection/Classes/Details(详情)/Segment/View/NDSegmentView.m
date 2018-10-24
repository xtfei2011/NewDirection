//
//  NDSegmentView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSegmentView.h"
#import "NDSegmentParam.h"
#import "NDSegmentViewCell.h"

@interface NDSegmentView ()<UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSArray *dataArray;
@property (nonatomic ,strong) NDSegmentParam *segmentParam;
@property (nonatomic ,assign) CGFloat itemWidth;
@property (nonatomic ,assign) NSInteger selectedIndex;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) NSMutableArray *cellArray;

@end

@implementation NDSegmentView

#pragma mark ===== 懒加载
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, _segmentParam.margin, 0, _segmentParam.margin);
        layout.minimumLineSpacing = _segmentParam.spacing;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[NDSegmentViewCell class] forCellWithReuseIdentifier:@"NDSegmentViewCell"];
        
        [self addSubview:_collectionView];
        [self lineView];
    }
    return _collectionView;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(_segmentParam.margin + (self.itemWidth + _segmentParam.spacing) * _segmentParam.startIndex, self.collectionView.xtfei_height - 2, self.itemWidth, 2)];
        
        _lineView.hidden = !_segmentParam.showLine;
        
        CGFloat lineW = _segmentParam.lineWidth < 0 ? self.itemWidth * 0.6 : _segmentParam.lineWidth;
        UIView *sline = [[UIView alloc] initWithFrame:CGRectMake((_lineView.xtfei_width - lineW) * 0.5, 0, lineW, _lineView.xtfei_height)];
        sline.backgroundColor = _segmentParam.lineColor;
        sline.layer.masksToBounds = YES;
        sline.layer.cornerRadius = _lineView.xtfei_height *0.5;
        [_lineView addSubview:sline];
        
        [self.collectionView addSubview:_lineView];
        
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_segmentParam.startIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
    return _lineView;
}

- (CGFloat)itemWidth
{
    if (_itemWidth <= 0) {
        _itemWidth = (_collectionView.xtfei_width - 2 * _segmentParam.margin - (_dataArray.count - 1) * _segmentParam.spacing)/_dataArray.count;
    }
    return _itemWidth;
}

#pragma mark ===== 初始化
- (instancetype)initWithFrame:(CGRect)frame segmentParam:(NDSegmentParam *)segmentParam
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.segmentParam = segmentParam;
        self.selectedIndex = segmentParam.startIndex;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)reloadDataArray:(NSArray<NSString *> *)data
{
    self.dataArray = data;
    
    [[self collectionView] reloadData];
}

#pragma mark ===== 初始化 CollectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.itemWidth, self.xtfei_height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.associatedScrollBlock == nil) {
        self.selectedIndex = indexPath.row;
        [collectionView reloadData];
    }
    if (self.selectedIndexBlock) {
        self.selectedIndexBlock(indexPath.row);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDSegmentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NDSegmentViewCell" forIndexPath:indexPath];
    [cell updateTitle:_dataArray[indexPath.row] segmentParam:self.segmentParam];
    [cell didSelected:(indexPath.row == self.selectedIndex)];
    
    if (self.cellArray == nil) {
        self.cellArray = [NSMutableArray array];
    }
    if (![self.cellArray containsObject:cell]) {
        [self.cellArray addObject:cell];
    }
    return cell;
}

- (void)selectIndex:(NSInteger)index animated:(BOOL)animated
{
    self.selectedIndex = index;
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

- (void)setAssociatedScroll
{
    __weak NDSegmentView *weakSelf = self;
    self.associatedScrollBlock = ^(UIScrollView *scrollView) {
        
        if (weakSelf.collectionView.contentSize.width <= 0) return;
        
        CGFloat offsetX = scrollView.contentOffset.x;
        int page = offsetX / scrollView.xtfei_width;
        
        if (offsetX < 0.0) {
            offsetX = 0;
            page = -1;
        }
        if (offsetX > scrollView.contentSize.width - scrollView.xtfei_width) {
            offsetX = scrollView.contentSize.width - scrollView.xtfei_width;
            page = -1;
        }
        CGFloat width = weakSelf.collectionView.contentSize.width - weakSelf.segmentParam.margin;
        CGFloat lx = offsetX * width / scrollView.contentSize.width;
        
        weakSelf.lineView.frame = CGRectMake(weakSelf.segmentParam.margin + lx, weakSelf.lineView.xtfei_y, weakSelf.lineView.xtfei_width, weakSelf.lineView.xtfei_height);
        
        if (page >= 0) {
            CGFloat dspace = weakSelf.itemWidth + weakSelf.segmentParam.spacing;
            
            for (NDSegmentViewCell *cell in [weakSelf cellArray]) {
                
                CGFloat scale = fabs(cell.xtfei_centerX - weakSelf.lineView.xtfei_centerX) / dspace;
                
                if (scale <= 0.5) {
                    cell.textLabel.textColor = weakSelf.segmentParam.selectedColor;
                } else {
                    cell.textLabel.textColor = weakSelf.segmentParam.defaultColor;
                }
            }
        }
    };
}
@end
