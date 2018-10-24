//
//  NDNewfeatureController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/15.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDNewfeatureController.h"

@interface NDNewfeatureController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation NDNewfeatureController
static CGFloat const CXYNewfeatureCount = 3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScrollView];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat scrollW = scrollView.xtfei_width;
    CGFloat scrollH = scrollView.xtfei_height;
    
    for (int i = 0; i < CXYNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.xtfei_width = scrollW;
        imageView.xtfei_height = scrollH;
        imageView.xtfei_y = 0;
        imageView.xtfei_x = i *scrollW;
        
        NSString *name = [NSString stringWithFormat:@"introduced00%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        if (i == 2) {
            [self setupLastImageView:imageView];
        }
    }
    scrollView.contentSize = CGSizeMake(CXYNewfeatureCount *scrollW, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [startBtn setTitleColor:NDColor(245, 60, 98) forState:UIControlStateNormal];
    startBtn.backgroundColor = [UIColor whiteColor];
    startBtn.layer.masksToBounds = YES;
    startBtn.layer.cornerRadius = 20;
    startBtn.layer.borderWidth = 1;
    startBtn.layer.borderColor = NDColor(245, 60, 98).CGColor;
    
    startBtn.xtfei_width = 150;
    startBtn.xtfei_height = 40;
    startBtn.xtfei_centerX = imageView.xtfei_width * 0.5;
    startBtn.xtfei_centerY = imageView.xtfei_height * 0.85;
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

- (void)startClick
{
    
}

- (void)dealloc
{
    NDLog(@"CXYNewfeatureViewController-dealloc");
}

@end
