//
//  NDDomainController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDDomainController.h"

@interface NDDomainController ()

@end

@implementation NDDomainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择专业";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupView];
}

- (void)setupView
{
    NSArray *domain = @[@"临床医学" ,@"口腔医学" ,@"血液内科" ,@"神经外科"];
    int totalloc = 3;
    CGFloat btnW = (NDMainScreen_Width - 20 * 4)/3;
    CGFloat btnH = 30;
    CGFloat margin = 20;
    NSInteger count = 4;
    
    for (int i = 0; i < count; i++) {
        int row = i / totalloc;
        int loc = i % totalloc;
        CGFloat btnX = margin + (margin + btnW) *loc;
        CGFloat btnY = 30 + (margin + btnH) *row;
        
        UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        starBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [starBtn setTitle:domain[i] forState:UIControlStateNormal];
        [starBtn setTitleColor:NDColor(69, 133, 245) forState:UIControlStateNormal];
        starBtn.titleLabel.font = NDCommodityTitleFont;
        starBtn.tag = i + 3000;
        starBtn.layer.cornerRadius = 15;
        starBtn.layer.borderColor = NDColor(69, 133, 245).CGColor;
        starBtn.layer.borderWidth = 0.5;
        [starBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:starBtn];
    }
}

- (void)titleBtnClick:(UIButton *)button
{
    NSUInteger num = 4;
    
    for (NSInteger i = 0; i < num; i++) {
        UIButton *btn = [self.view viewWithTag:i + 3000];
        
        if (btn.tag != button.tag) {
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitleColor:NDColor(69, 133, 245) forState:UIControlStateNormal];
        } else {
            [btn setBackgroundColor:NDColor(69, 133, 245)];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    
    [NDUSER_DEFAULTS setObject:button.titleLabel.text forKey:@"major"];
    [NDUSER_DEFAULTS synchronize];
    
    NSString *major = [NDUSER_DEFAULTS objectForKey:@"major"];
    self.signature(major);
    if (major) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
