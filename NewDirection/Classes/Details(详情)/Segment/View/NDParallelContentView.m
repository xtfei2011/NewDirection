//
//  NDParallelContentView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDParallelContentView.h"
#import <WebKit/WebKit.h>

@interface NDParallelContentView ()

@end

@implementation NDParallelContentView

- (instancetype)initWithSegmentTitle:(NSString *)title
{
    if ([super init]) {
        self.title = title;
    }
    return self;
}

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    
    if ([subview isKindOfClass:[UIScrollView class]]) {
        if (self.didAddScrollViewBlock) {
            self.didAddScrollViewBlock((UIScrollView *)subview ,_index);
        }
    } else if ([subview isKindOfClass:[WKWebView class]]) {
        if (self.didAddScrollViewBlock) {
            self.didAddScrollViewBlock(((WKWebView *)subview).scrollView ,_index);
        }
    } else if ([subview isKindOfClass:[UIWebView class]]) {
        if (self.didAddScrollViewBlock) {
            self.didAddScrollViewBlock(((UIWebView *)subview).scrollView ,_index);
        }
    } else {
        for (UIView *sview in [subview subviews]) {
            if ([sview isKindOfClass:[UIScrollView class]]) {
                if (self.didAddScrollViewBlock) {
                    self.didAddScrollViewBlock((UIScrollView *)sview ,_index);
                }
            }
        }
    }
}

- (void)refreshContentView
{
}
@end
