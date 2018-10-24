//
//  NDConsultViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDConsultViewController.h"
#import <WebKit/WebKit.h>

@interface NDConsultViewController ()
@property (nonatomic ,strong) WKWebView *webView;
@end

@implementation NDConsultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self webView];
}

- (WKWebView *)webView
{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://p.qiao.baidu.com/cps/chat?siteId=12616955&userId=26438663"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        request = [mutableRequest copy];
        
        [_webView loadRequest:request];
        [self.view addSubview:_webView];
    }
    return _webView;
}
@end
