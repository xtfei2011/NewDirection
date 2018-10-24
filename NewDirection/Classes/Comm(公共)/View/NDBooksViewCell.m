//
//  NDBooksViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDBooksViewCell.h"

@interface NDBooksViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;
@property (weak, nonatomic) IBOutlet UILabel *reducedPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
/*** 分割线 ***/
@property (weak, nonatomic) IBOutlet UIView *divisionView;

@end

@implementation NDBooksViewCell

static NSString *const cellID = @"NDBooksViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDBooksViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDBooksViewCell" owner:nil options:nil] firstObject];
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
    self.writerLabel.text = [NSString stringWithFormat:@"作者：%@",comment.writer];
    
    if ([comment.original_price isEqualToString:@"0"]) {
        self.originalPriceLabel.hidden = YES;
        self.divisionView.hidden = YES;
    } else {
        self.originalPriceLabel.hidden = NO;
        self.divisionView.hidden = NO;
        self.originalPriceLabel.text = [NSString stringWithFormat:@"原价：%@",comment.original_price];
    }
    
    self.reducedPriceLabel.text = [NSString stringWithFormat:@"¥%@",comment.currentPrice];
}
@end
