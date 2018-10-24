//
//  NDPreviewLiveViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDPreviewLiveViewCell.h"

@interface NDPreviewLiveViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;
@end

@implementation NDPreviewLiveViewCell
static NSString *const cellID = @"NDPreviewLiveViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NDPreviewLiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NDPreviewLiveViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:@"http://m.qpic.cn/psb?/V13Js1iM3urn8H/nmcvstrsTpXBuuPSif0Io1Gf.RYfM2gsrch4KUNyzWo!/b/dDQBAAAAAAAA&bo=wAFQAQAAAAADF6I!&rf=viewer_4"]];
}

@end
