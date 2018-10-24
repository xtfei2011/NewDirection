//
//  NDTextView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NDTextView;
@interface NDTextView : UITextView<UITextViewDelegate>
/*** 占位文字 ***/
@property (nonatomic ,copy) NSString *placehoder;
/*** 文字最大个数 ***/
@property (nonatomic ,assign) NSInteger maxLength;

@property (nonatomic) UIColor *titleColor;

@property (nonatomic ,copy) void (^changeText)(NDTextView *textView);
- (void)changeText:(void (^)(NDTextView *textView))block;
@end
