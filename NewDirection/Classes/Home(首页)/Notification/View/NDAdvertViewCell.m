//
//  NDAdvertViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/25.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDAdvertViewCell.h"

@interface NDAdvertViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NDAdvertViewCell
static NSString *const cellID = @"NDAdvertViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDAdvertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDAdvertViewCell" owner:nil options:nil] firstObject];
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
}
@end
