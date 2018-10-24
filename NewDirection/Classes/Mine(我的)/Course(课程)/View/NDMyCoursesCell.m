//
//  NDMyCoursesCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDMyCoursesCell.h"

@interface NDMyCoursesCell ()

@end

@implementation NDMyCoursesCell

static NSString *const cellID = @"NDMyCoursesCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDMyCoursesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDMyCoursesCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
