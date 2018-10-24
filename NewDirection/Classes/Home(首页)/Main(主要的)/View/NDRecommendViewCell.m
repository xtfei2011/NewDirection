//
//  NDRecommendViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDRecommendViewCell.h"

@interface NDRecommendViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@end

@implementation NDRecommendViewCell
static NSString *const cellID = @"NDRecommendViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDRecommendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDRecommendViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setCourse:(NDComment *)course
{
    _course = course;
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:course.image_path]];
    self.titleLabel.text = course.title;
}
@end
