//
//  UIImage+TFImageHelper.h
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/21.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TFImageHelper)

- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color;
- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha;
- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color rect:(CGRect)rect;
- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color insets:(UIEdgeInsets)insets;
- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets;
- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha rect:(CGRect)rect;

@end
