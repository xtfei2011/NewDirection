//
//  NDClassifyView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDClassifyView.h"
#import "NDClassifyItemCell.h"
#import "NDTabBarController.h"
#import "NDNavigationController.h"

#define kCellCountInRow 4
#define kCellMargin 1
@interface NDClassifyView ()<UICollectionViewDataSource ,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@end

@implementation NDClassifyView
static NSString *const itemID = @"NDClassifyItemCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    /*** 初始化 ***/
    CGFloat classifyViewW = NDMainScreen_Width - 20;
    CGFloat classifyViewH = ((classifyViewW - (kCellCountInRow + 1) * kCellMargin) / kCellCountInRow) * 2 + 21;
    self.frame = CGRectMake(10, 469 * NDMainScreen_Width / 828 + 10, classifyViewW, classifyViewH);
    
    [self setShadowWithShadowOffset:CGSizeMake(0, 0) shadowColor:[UIColor lightGrayColor] shadowRadius:6.f shadowOpacity:0.8 cornerRadius:6.0];
    
    /*** 设置 item ***/
    CGFloat width = (self.xtfei_width - (kCellCountInRow + 1) * kCellMargin) / kCellCountInRow;
    CGFloat height = width;
    
    self.flowLayout.itemSize = CGSizeMake(width, height);
    self.flowLayout.minimumInteritemSpacing = kCellMargin;
    self.flowLayout.minimumLineSpacing = kCellMargin;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0.5, 0, 0.5);
    
    UINib *nib = [UINib nibWithNibName:@"NDClassifyItemCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:itemID];
}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDClassifyItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    cell.index = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*** 获得 我的 模块对应的导航控制器 ***/
    NDTabBarController *tabBar = (NDTabBarController *)self.window.rootViewController;
    NDNavigationController *nav = tabBar.selectedViewController;
    
    UIViewController *viewClass = [[NSClassFromString(MineControllerArray[indexPath.row]) alloc] init];
    [nav pushViewController:viewClass animated:YES];
}

@end
