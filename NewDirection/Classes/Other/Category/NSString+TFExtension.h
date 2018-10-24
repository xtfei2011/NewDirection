//
//  NSString+TFExtension.h
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+TFExtension.h"

@interface NSString (TFExtension)
/**
 *  手机号码验证
 */
- (BOOL)isValidateMobile;

/**
 *  返回字符串所占用的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  清理缓存
 */
- (unsigned long long)fileSize;
@end
