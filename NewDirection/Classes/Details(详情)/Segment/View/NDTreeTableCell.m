//
//  NDTreeTableCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/19.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import "NDTreeTableCell.h"

@implementation NDTreeTableCell
static NSString *const cellID = @"NDTreeTableCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDTreeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDTreeTableCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.textLabel.font = NDCommentTitleFont;
    self.textLabel.textColor = NDColor(80, 85, 101);
}

@end
