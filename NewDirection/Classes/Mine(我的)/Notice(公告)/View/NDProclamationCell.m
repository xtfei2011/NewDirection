//
//  NDProclamationCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDProclamationCell.h"

@implementation NDProclamationCell

static NSString *const cellID = @"NDProclamationCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDProclamationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDProclamationCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
