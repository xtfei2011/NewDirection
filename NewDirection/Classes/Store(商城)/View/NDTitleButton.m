//
//  NDTitleButton.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDTitleButton.h"

@implementation NDTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:NDColor(139, 142, 152) forState:UIControlStateNormal];
        [self setTitleColor:NDColor(62, 67, 84) forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted{}

@end
