//
//  NDDetailsViewCell.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/8.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDStore.h"
#import "NDComment.h"

@interface NDDetailsViewCell : UITableViewCell

@property (nonatomic ,assign) NDSegmentedType type;
@property (nonatomic ,strong) NDComment *comment;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
