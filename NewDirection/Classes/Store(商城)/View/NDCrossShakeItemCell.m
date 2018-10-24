//
//  NDCrossShakeItemCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/17.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCrossShakeItemCell.h"

@interface NDCrossShakeItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation NDCrossShakeItemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:@"http://m.qpic.cn/psb?/V13Js1iM3urn8H/sWQq*oZZdQTaYUnIsR.Ko15rmYinaC*nlfTo*AptWdI!/b/dEkBAAAAAAAA&bo=wAFQAQAAAAADF6I!&rf=viewer_4"]];
}

@end
