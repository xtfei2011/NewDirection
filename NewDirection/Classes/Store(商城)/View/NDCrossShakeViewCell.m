//
//  NDCrossShakeViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/17.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCrossShakeViewCell.h"
#import "NDCrossShakeItemCell.h"
#import "NDCrossShakeDetailController.h"
#import "NDLiveViewController.h"

#define kCellCountInRow 2
#define kCellMargin 5
@interface NDCrossShakeViewCell ()<UICollectionViewDataSource ,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@end

@implementation NDCrossShakeViewCell

static NSString *const cellID = @"NDCrossShakeViewCell";
static NSString *const itemID = @"itemID";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDCrossShakeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDCrossShakeViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat width = (NDMainScreen_Width - kCellMargin - 80) / kCellCountInRow;
    CGFloat height = width *0.75 + 80;
    self.flowLayout.itemSize = CGSizeMake(width, height);
    self.flowLayout.minimumLineSpacing = 0;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UINib *nib = [UINib nibWithNibName:@"NDCrossShakeItemCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:itemID];
    
    [self.collectionView reloadData];
}

//- (void)setComment:(NSMutableArray<NDComment *> *)comment
//{
//    _comment = comment;
//    
//    [self.collectionView reloadData];
//}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDCrossShakeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
//    cell.comment = self.comment[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDCrossShakeItemCell *cell = (NDCrossShakeItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NDLiveViewController *homeVC = (NDLiveViewController *)[cell currentViewController];

    NDCrossShakeDetailController *detailsVC = [[NDCrossShakeDetailController alloc] init];
    [homeVC.navigationController pushViewController:detailsVC animated:YES];
}

@end
