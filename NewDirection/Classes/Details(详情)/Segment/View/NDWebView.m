//
//  NDWebView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDWebView.h"
#import <WebKit/WebKit.h>

@interface NDWebView ()

@property (nonatomic ,strong) WKWebView *webView;
@end

@implementation NDWebView

- (void)refreshContentView
{
    [self webView];
}

- (WKWebView *)webView
{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:self.bounds];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        request = [mutableRequest copy];
        
        [_webView loadRequest:request];
        [self addSubview:_webView];
    }
    return _webView;
}

@end
