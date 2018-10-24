//
//  NDNotificationViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDNotificationViewCell.h"

@interface NDNotificationViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation NDNotificationViewCell

static NSString *const cellID = @"NDNotificationViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDNotificationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDNotificationViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setAdvert:(NDAdvert *)advert
{
    _advert = advert;
    
    self.titleLabel.text = advert.title;
    
    self.contentLabel.text = advert.content;
}
@end
