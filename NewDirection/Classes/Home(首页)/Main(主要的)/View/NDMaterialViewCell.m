//
//  NDMaterialViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDMaterialViewCell.h"
#import "NDMaterialItemCell.h"
#import "NDHomeViewController.h"
#import "NDDetailsController.h"

#define kCellCountInRow 3
#define kCellMargin 5
@interface NDMaterialViewCell ()<UICollectionViewDataSource ,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@end

@implementation NDMaterialViewCell
static NSString *const cellID = @"NDMaterialViewCell";
static NSString *const itemID = @"itemID";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDMaterialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDMaterialViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat width = (NDMainScreen_Width - kCellMargin) / kCellCountInRow;
    CGFloat height = width * 1.4;
    self.flowLayout.itemSize = CGSizeMake(width, height);
    self.flowLayout.minimumLineSpacing = 0;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
    
    UINib *nib = [UINib nibWithNibName:@"NDMaterialItemCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:itemID];

    [self.collectionView reloadData];
}

- (void)setComment:(NSMutableArray<NDComment *> *)comment
{
    _comment = comment;
    
    [self.collectionView reloadData];
}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDMaterialItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    cell.comment = self.comment[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDMaterialItemCell *cell = (NDMaterialItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NDHomeViewController *homeVC = (NDHomeViewController *)[cell currentViewController];
    
    NDDetailsController *detailsVC = [[NDDetailsController alloc] init];
    detailsVC.type = 3;
    detailsVC.comment = self.comment[indexPath.row];
    [homeVC.navigationController pushViewController:detailsVC animated:YES];
}
@end
