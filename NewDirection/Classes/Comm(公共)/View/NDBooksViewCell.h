//
//  NDBooksViewCell.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDComment.h"

@interface NDBooksViewCell : UITableViewCell

@property (nonatomic ,strong) NDComment *comment;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
