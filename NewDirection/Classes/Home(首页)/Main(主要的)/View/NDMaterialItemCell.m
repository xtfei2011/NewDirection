//
//  NDMaterialItemCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDMaterialItemCell.h"
#import "UIImageView+WebCache.h"

@interface NDMaterialItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation NDMaterialItemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}

- (void)setComment:(NDComment *)comment
{
    _comment = comment;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:comment.image_path] placeholderImage:nil];
    
    self.titleLabel.text = comment.title;
    
    self.priceLabel.text = comment.currentPrice;
}

@end
