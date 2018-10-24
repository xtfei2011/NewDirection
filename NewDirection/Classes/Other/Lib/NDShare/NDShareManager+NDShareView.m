//
//  NDShareManager+NDShareView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/15.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDShareManager+NDShareView.h"
#import "NDShareButton.h"

@implementation NDShareManager (NDShareView)

- (void)creatShareView
{
    self.maskView = [[UIView alloc] initWithFrame:NDScreeFrame];
    [NDkeyWindowView addSubview:self.maskView];
    [NDkeyWindowView bringSubviewToFront:self.maskView];
    
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NDMainScreen_Width, NDMainScreen_Height - 200)];
    topView.userInteractionEnabled = YES;
    [self.maskView addSubview:topView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenShareView)];
    [topView addGestureRecognizer:tap];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, NDMainScreen_Height, NDMainScreen_Width, 200)];
    self.shareView.backgroundColor = [UIColor whiteColor];
    [self.maskView addSubview:self.shareView];
    
    UILabel *shareLeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, NDMainScreen_Width, 15)];
    shareLeLabel.text = NSLocalizedString(@"分享到", nil);
    shareLeLabel.textColor = [UIColor lightGrayColor];
    shareLeLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:shareLeLabel];
    
    CGFloat itemWidth = (NDMainScreen_Width - 100)/4;
    UIView *shareBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shareLeLabel.frame) + 10, NDMainScreen_Width, itemWidth + 15)];
    [self.shareView addSubview:shareBaseView];
    
    for (int i = 0; i < shareNameArray.count; i++) {
        
        NDShareButton *shareBtn = [[NDShareButton alloc] initWithFrame:CGRectMake(20 + i % 4 * (itemWidth + 20), 10, itemWidth, itemWidth + 10)];
        [shareBtn setImage:[UIImage imageNamed:shareImageArray[i]] forState:UIControlStateNormal];
        [shareBtn setTitle:shareNameArray[i] forState:UIControlStateNormal];
        shareBtn.tag = i;
        [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [shareBaseView addSubview:shareBtn];
    }
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(10, CGRectGetMaxY(shareBaseView.frame) + 25, self.shareView.xtfei_width - 20, 44);
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 6.0f;
    cancelBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    cancelBtn.layer.borderWidth = 0.8f;
    cancelBtn.tintColor = [UIColor grayColor];
    [cancelBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hiddenShareView) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:cancelBtn];
    self.maskView.hidden = YES;
}
@end
