//
//  NDRightViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/18.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import "NDRightViewCell.h"

@interface NDRightViewCell ()

@end

@implementation NDRightViewCell
static NSString *const cellID = @"NDRightViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDRightViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDRightViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
