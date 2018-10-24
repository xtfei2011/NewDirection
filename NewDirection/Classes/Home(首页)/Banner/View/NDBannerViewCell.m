//
//  NDBannerViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDBannerViewCell.h"

@interface NDBannerViewCell ()
/*** 图片 ***/
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@end

@implementation NDBannerViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setBanner:(NDBanner *)banner
{
    _banner = banner;
    
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:banner.image_path]];
}
@end
