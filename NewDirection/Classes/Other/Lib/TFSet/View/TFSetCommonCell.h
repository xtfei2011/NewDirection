//
//  TFSetCommonCell.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFSetCommonItem;
@interface TFSetCommonCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

/** cell对应的item数据 */
@property (nonatomic ,strong) TFSetCommonItem *item;
@end
