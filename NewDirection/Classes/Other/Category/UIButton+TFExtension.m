
//
//  UIButton+TFExtension.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIButton+TFExtension.h"

@implementation UIButton (TFExtension)

+ (UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button sizeToFit];
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.xtfei_width - button.xtfei_width + button.titleLabel.xtfei_width, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.xtfei_width - button.xtfei_width + button.imageView.xtfei_width);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
@end
