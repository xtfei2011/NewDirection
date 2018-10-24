//
//  NDCultivateViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCultivateViewCell.h"

@interface NDCultivateViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation NDCultivateViewCell

static NSString *const cellID = @"NDCultivateViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDCultivateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDCultivateViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setComment:(NDComment *)comment
{
    _comment = comment;
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:comment.image_path]];
    self.titleLabel.text = comment.title;
    
    self.addressLabel.text = [NSString stringWithFormat:@"面授地址:%@",comment.address];
    self.timeLabel.text = [NSString stringWithFormat:@"面授时间:%@",comment.time];
}
@end
