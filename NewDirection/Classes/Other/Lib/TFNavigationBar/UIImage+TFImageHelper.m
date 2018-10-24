//
//  UIImage+TFImageHelper.m
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/21.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIImage+TFImageHelper.h"

@implementation UIImage (TFImageHelper)

- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color
{
    return [self xtfei_updateImageWithTintColor:color alpha:1.0f];
}

- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    return [self xtfei_updateImageWithTintColor:color alpha:alpha rect:rect];
}

- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color rect:(CGRect)rect
{
    return [self xtfei_updateImageWithTintColor:color alpha:1.0f rect:rect];
}

- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color insets:(UIEdgeInsets)insets
{
    return [self xtfei_updateImageWithTintColor:color alpha:1.0f insets:insets];
}

- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets
{
    CGRect originRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    CGRect tintImageRect = UIEdgeInsetsInsetRect(originRect, insets);
    return [self xtfei_updateImageWithTintColor:color alpha:alpha rect:tintImageRect];
}

#pragma mark - 全能初始化方法
- (UIImage *)xtfei_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha rect:(CGRect)rect
{
    CGRect imageRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    [self drawInRect:imageRect];

    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    CGContextSetAlpha(contextRef, alpha);
    CGContextSetBlendMode(contextRef, kCGBlendModeSourceAtop);
    CGContextFillRect(contextRef, rect);

    CGImageRef imageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *tintedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];

    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
@end
