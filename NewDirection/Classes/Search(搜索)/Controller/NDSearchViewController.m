//
//  NDSearchViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSearchViewController.h"
#import "NDSearchSection.h"
#import "NDSearch.h"
#import "NDSearchCollectionCell.h"
#import "NDSearchReusableView.h"
#import "NDSearchCollectionLayout.h"
#import "NDDBHandle.h"
#import "NDSearchView.h"
#import "NDOptionViewController.h"

@interface NDSearchViewController ()<UICollectionViewDataSource ,UICollectionViewDelegate ,NDSearchReusableViewDelegate ,UITextFieldDelegate>

@property (nonatomic ,strong) NSMutableArray *sectionArray;
@property (nonatomic ,strong) NSMutableArray *searchArray;
@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;

@property (nonatomic ,strong) NDSearchView *searchView;
@end

@implementation NDSearchViewController

static NSString *const SearchCollectionCellID = @"NDSearchCollectionCell";
static NSString *const SearchReusableID = @"NDSearchReusableView";

- (NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

- (NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (NDSearchView *)searchView
{
    if (!_searchView) {
        _searchView = [[NDSearchView alloc] initWithFrame:CGRectMake(50, 7, NDMainScreen_Width - 100, 30)];
    }
    return _searchView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.searchView;
    self.searchView.searchField.delegate = self;
    
    [self prepareData];
    
    [self.searchCollectionView setCollectionViewLayout:[[NDSearchCollectionLayout alloc] init] animated:YES];
    [self.searchCollectionView registerClass:[NDSearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SearchReusableID];
    [self.searchCollectionView registerNib:[UINib nibWithNibName:@"NDSearchCollectionCell" bundle:nil] forCellWithReuseIdentifier:SearchCollectionCellID];
}

- (void)prepareData
{
    /*** 模拟数据 ***/
    NSArray *testArray = @[@{@"section_id":@"1",
                             @"section_title":@"热门职位",
                             @"section_content":
                                 @[@{@"search_content":@"口腔主治"},
                                   @{@"search_content":@"口腔技术"},
                                   @{@"search_content":@"西药师"},
                                   @{@"search_content":@"中药师"},
                                   @{@"search_content":@"主管护士"},
                                   @{@"search_content":@"临床医师"},
                                   @{@"search_content":@"护士资格(高级)"},
                                   @{@"search_content":@"本草纲目"},
                                   @{@"search_content":@"中西医医师(配药)"},
                                   @{@"search_content":@"中西医医师"},
                                   @{@"search_content":@"主管护师"},
                                   @{@"search_content":@"孙思邈"},
                                   @{@"search_content":@"主治医师(中级)"}
                                   ]},
                           ];
    
    NSMutableArray *array = [@[] mutableCopy];
    [array addObjectsFromArray:testArray];
    
    /***  查询数据库是否存在数据 ***/
    NSDictionary *param = @{@"category":@"1"};
    NSDictionary *dict = [NDDBHandle statusesWithParams:param];
    
    if (dict.count) {
        [array addObject:dict];
        [self.searchArray addObjectsFromArray:dict[@"section_content"]];
    }
    
    for (NSDictionary *sectionDict in array) {
        NDSearchSection *model = [[NDSearchSection alloc] initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NDSearchSection *searchSection = self.sectionArray[section];
    return searchSection.section_Array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDSearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SearchCollectionCellID forIndexPath:indexPath];
    NDSearchSection *searchSection = self.sectionArray[indexPath.section];
    NDSearch *search = searchSection.section_Array[indexPath.row];
    cell.search = search;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NDSearchReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SearchReusableID forIndexPath:indexPath];
    
    reusableView.delegate = self;
    NDSearchSection *searchSection = self.sectionArray[indexPath.section];
    reusableView.title = searchSection.section_title;
    
    if ([reusableView.title isEqualToString:@"历史记录"]) {
        reusableView.delectBtn.hidden = NO;
    } else {
        reusableView.delectBtn.hidden = YES;
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NDSearchSection *searchSection = self.sectionArray[indexPath.section];
    if (searchSection.section_Array.count > 0) {
        NDSearch *search = searchSection.section_Array[indexPath.row];
        
        CGSize size = [search.search_content sizeWithFont:NDCommentTitleFont maxSize:CGSizeMake(CGFLOAT_MAX, 30)];
        return CGSizeMake(size.width + 20, 30);
    }
    return CGSizeMake(80, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NDSearchSection *searchSection = self.sectionArray[indexPath.section];
    NDSearch *search = searchSection.section_Array[indexPath.row];
    
    NDOptionViewController *optionVC = [[NDOptionViewController alloc] init];
    optionVC.navigationItem.title = search.search_content;
    [self.navigationController pushViewController:optionVC animated:YES];
}

/*** 搜索框部分 ***/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchView.searchField resignFirstResponder];
}

/*** 清空历史数据 ***/
- (void)delectButtonClick:(NDSearchReusableView *)view
{
    [UIAlertController showAlertWithTitle:@"温馨提示" message:@"您确定要清空历史数据吗？" actionTitles:@[@"确定"] cancelTitle:@"取消" style:UIAlertControllerStyleAlert completion:^(NSInteger index) {

        if (self.sectionArray.count > 1) {

            [self.sectionArray removeLastObject];
            [self.searchArray removeAllObjects];
            [self.searchCollectionView reloadData];
            [NDDBHandle saveStatuses:@{} param:@{@"category":@"1"}];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"search_content"]]) {
        return YES;
    }
    [self reloadData:textField.text];
    return YES;
}

- (void)reloadData:(NSString *)textString
{
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"search_content"]];
    
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    
    /*** 由于数据量并不大 这样每次存入再删除没问题  存数据库 ***/
    NSDictionary *param = @{@"category":@"1"};
    [NDDBHandle saveStatuses:searchDict param:param];
    
    NDSearchSection *model = [[NDSearchSection alloc] initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.searchCollectionView reloadData];
    self.searchView.searchField.text = @"";
}

@end
