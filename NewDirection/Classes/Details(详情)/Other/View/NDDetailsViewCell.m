//
//  NDDetailsViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/8.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDDetailsViewCell.h"

@interface NDDetailsViewCell ()
/*** 封面 ***/
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
/*** 标题 ***/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/*** 介绍 ***/
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
/*** 时间 ***/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/*** 地点 ***/
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;
#pragma mark ===== 图书资料

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *liveView;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;

@end

@implementation NDDetailsViewCell
static NSString *const cellID = @"NDDetailsViewCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDDetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDDetailsViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setType:(NDSegmentedType)type
{
    _type = type;
    
    /*** 面授培训 ***/
    if (type == NDSegmentedTypeCultivate) {
        
        self.timeLabel.hidden = NO;
        self.siteLabel.hidden = NO;
        
        self.priceLabel.hidden = YES;
        self.currentPriceLabel.hidden = YES;
        self.originalPriceLabel.hidden = YES;
        self.liveView.hidden = YES;
        self.writerLabel.hidden = YES;
        
    } else {
        self.timeLabel.hidden = YES;
        self.siteLabel.hidden = YES;
        
        self.priceLabel.hidden = NO;
        self.currentPriceLabel.hidden = NO;
        self.originalPriceLabel.hidden = NO;
        self.liveView.hidden = NO;
        self.writerLabel.hidden = NO;
    }
}

- (void)setComment:(NDComment *)comment
{
    _comment = comment;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:comment.big_image]];
    
    self.titleLabel.text = comment.title;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥%@",comment.currentPrice];
    self.originalPriceLabel.text = [NSString stringWithFormat:@"(原价:¥%@)",comment.original_price];
    self.writerLabel.text = [NSString stringWithFormat:@"作者:%@",comment.writer];
    
    self.siteLabel.text = [NSString stringWithFormat:@"面授地址:%@",comment.address];
    self.timeLabel.text = [NSString stringWithFormat:@"面授时间:%@",comment.time];
}
@end
