//
//  NDLiveViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDLiveViewCell.h"

@interface NDLiveViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;

@end

@implementation NDLiveViewCell

static NSString *const cellID = @"NDLiveViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDLiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDLiveViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:@"http://m.qpic.cn/psb?/V13Js1iM3urn8H/sWQq*oZZdQTaYUnIsR.Ko15rmYinaC*nlfTo*AptWdI!/b/dEkBAAAAAAAA&bo=wAFQAQAAAAADF6I!&rf=viewer_4"]];
}
@end
