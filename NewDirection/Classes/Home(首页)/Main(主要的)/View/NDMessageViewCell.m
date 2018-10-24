//
//  NDMessageViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDMessageViewCell.h"

@implementation NDMessageViewCell

static NSString *const cellID = @"NDMessageViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDMessageViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
