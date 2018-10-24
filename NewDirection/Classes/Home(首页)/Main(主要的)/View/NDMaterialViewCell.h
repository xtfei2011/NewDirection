//
//  NDMaterialViewCell.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDComment.h"

@interface NDMaterialViewCell : UITableViewCell

@property (nonatomic ,strong) NSMutableArray<NDComment *> *comment;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
