//
//  NDOpinionViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDOpinionViewController.h"
#import "NDTextView.h"

#define MaxTextCount 150
@interface NDOpinionViewController ()
/*** 文本框输入控件 ***/
@property (weak, nonatomic) IBOutlet NDTextView *textView;
@end

@implementation NDOpinionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"意见反馈";
    
    [self setupTextView];
}

/*** 文字输入控件 ***/
- (void)setupTextView
{
    self.textView.maxLength = MaxTextCount;
    self.textView.placehoder = @"写下你的建议或遇到的问题···";
    [self.view addSubview:self.textView];
    
    [self.textView changeText:^(NDTextView *textView) {
        NDLog(@"--->%@",textView.text);
    }];
}
@end
