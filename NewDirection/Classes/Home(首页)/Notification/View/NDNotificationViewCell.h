//
//  NDNotificationViewCell.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDAdvert.h"

@interface NDNotificationViewCell : UITableViewCell

@property (nonatomic ,strong) NDAdvert *advert;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
