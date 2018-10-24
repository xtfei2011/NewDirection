//
//  NDSortView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/25.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSortView.h"
#import "NDBannerView.h"
#import "NDSortItemCell.h"
#import "NDHomeViewController.h"

#define kCellCountInRow 4
#define kCellMargin 10
@interface NDSortView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) NDBannerView *bannerView;
/*** 分类 View ***/
@property (nonatomic ,strong) UIView *sortView;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation NDSortView
static NSString *const itemID = @"NDSortItemCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializeSortView];
    }
    return self;
}

- (void)initializeSortView
{
    _bannerView = [[NDBannerView alloc] initWithFrame:CGRectMake(0, 0, self.xtfei_width, self.xtfei_height - 100)];
    [self addSubview:_bannerView];
    
    _sortView = [[UIView alloc] initWithFrame:CGRectMake(15, _bannerView.xtfei_bottom - 15, self.xtfei_width - 30, 100)];
    _sortView.backgroundColor = [UIColor whiteColor];
    [_sortView setShadowWithShadowOffset:CGSizeMake(0, 0) shadowColor:[UIColor lightGrayColor] shadowRadius:6.f shadowOpacity:0.8 cornerRadius:6.0];
    [self addSubview:_sortView];
    
    /*** 分类 ***/
    CGFloat width = (_sortView.xtfei_width - (kCellCountInRow + 1) * kCellMargin) / kCellCountInRow;
    CGFloat height = width + 10;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(width, height);
    _flowLayout.minimumInteritemSpacing = kCellMargin - 0.1;
    _flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:_sortView.bounds collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"NDSortItemCell" bundle:[NSBundle bundleForClass:[self class]]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:itemID];
    [_sortView addSubview:_collectionView];
}

- (void)setBanner:(NSMutableArray<NDBanner *> *)banner
{
    _banner = banner;
    
    _bannerView.banner = banner;
    [_collectionView reloadData];
}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDSortItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    cell.index = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDSortItemCell *cell = (NDSortItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NDHomeViewController *homeVC = (NDHomeViewController *)[cell currentViewController];
    
    UIViewController *viewClass = [[NSClassFromString(SortControllerArray[indexPath.row]) alloc] init];
    [viewClass setValue:@YES forKey:@"isUpload"];
    [homeVC.navigationController pushViewController:viewClass animated:YES];
}
@end
