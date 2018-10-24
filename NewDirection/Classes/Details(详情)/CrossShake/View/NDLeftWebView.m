//
//  NDLeftWebView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/18.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import "NDLeftWebView.h"
#import <WebKit/WebKit.h>

@interface NDLeftWebView ()

@property (nonatomic ,strong) WKWebView *webView;
@end

@implementation NDLeftWebView

- (void)refreshContentView
{
    [self webView];
}

- (WKWebView *)webView
{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:self.bounds];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.hao123.com"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        request = [mutableRequest copy];
        
        [_webView loadRequest:request];
        [self addSubview:_webView];
    }
    return _webView;
}

@end
