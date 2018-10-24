//
//  NDCourseViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCourseViewCell.h"

@interface NDCourseViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;
@property (weak, nonatomic) IBOutlet UILabel *reducedPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
/*** 分割线 ***/
@property (weak, nonatomic) IBOutlet UIView *divisionView;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@end

@implementation NDCourseViewCell

static NSString *const cellID = @"NDCourseViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDCourseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDCourseViewCell" owner:nil options:nil] firstObject];
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
    self.writerLabel.text = [NSString stringWithFormat:@"主讲人：%@",comment.writer];
    
    if ([comment.original_price isEqualToString:@"0"]) {
        self.originalPriceLabel.hidden = YES;
        self.divisionView.hidden = YES;
    } else {
        self.originalPriceLabel.hidden = NO;
        self.divisionView.hidden = NO;
        self.originalPriceLabel.text = [NSString stringWithFormat:@"¥%@",comment.original_price];
    }
    
    self.reducedPriceLabel.text = [NSString stringWithFormat:@"¥%@",comment.currentPrice];
    
    self.periodLabel.text = [NSString stringWithFormat:@"课时:%@",comment.period];
}
@end
