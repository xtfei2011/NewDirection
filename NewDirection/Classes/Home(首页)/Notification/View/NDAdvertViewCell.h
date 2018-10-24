//
//  NDAdvertViewCell.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/25.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDAdvert.h"

@interface NDAdvertViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) NDAdvert *advert;
@end
