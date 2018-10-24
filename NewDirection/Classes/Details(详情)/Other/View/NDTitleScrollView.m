//
//  NDTitleScrollView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/15.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDTitleScrollView.h"

@interface NDTitleScrollView ()
@property (nonatomic ,weak) UILabel *titleLabel;
@end

@implementation NDTitleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)setShowContent:(NSString *)showContent
{
    _showContent = showContent;
    
    [self.titleLabel removeFromSuperview];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    self.titleLabel = contentLabel;
    contentLabel.text = _showContent;
    contentLabel.textColor = NDGrayColor(43);
    [contentLabel sizeToFit];
    
    [self addSubview:contentLabel];
    self.contentSize = CGSizeMake(contentLabel.xtfei_width, 0);
    
    [contentLabel.layer removeAnimationForKey:@"move"];
    
    if (self.contentSize.width > self.xtfei_width) {
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.values = @[@0, @(-(self.contentSize.width - self.xtfei_width)), @0];
        animation.duration = showContent.length * 1;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;
        [contentLabel.layer addAnimation:animation forKey:@"move"];
    } else {
        contentLabel.xtfei_x = (self.xtfei_width - contentLabel.xtfei_width) *0.5;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.xtfei_centerY = self.xtfei_height * 0.5;
}

@end
