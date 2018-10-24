//
//  NDDetailsBottomView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/13.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDDetailsBottomView.h"
#import "NDDetailsController.h"
#import "NDApplyViewController.h"
#import "NDPaymentView.h"

@interface NDDetailsBottomView ()
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (nonatomic ,strong) NDPaymentView *paymentView;
@end

@implementation NDDetailsBottomView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, NDMainScreen_Height - 44 - iPhoneX_BOTTOM_HEIGHT, NDMainScreen_Width, 44 + iPhoneX_BOTTOM_HEIGHT);
}

- (void)setComment:(NDComment *)comment
{
    _comment = comment;
    
    // 直播
    if (self.type == NDSegmentedTypeLive) {
        
        if ([self.comment.type isEqualToString:@"0"]) { // 未报名
            [self.rightBtn setTitle:@"立即报名" forState:UIControlStateNormal];
            self.rightBtn.tag = 1000;
        } else if ([self.comment.type isEqualToString:@"1"]) { // 未购买
            [self.rightBtn setTitle:@"进入学习(¥299)" forState:UIControlStateNormal];
            self.rightBtn.tag = 1001;
        } else { // 已购买
            [self.rightBtn setTitle:@"进入学习(已支付)" forState:UIControlStateNormal];
            self.rightBtn.tag = 1002;
        }
    }
    if (self.type == NDSegmentedTypeCultivate) {
        if ([self.comment.type isEqualToString:@"0"]) { // 需要购买的未报名
            [self.rightBtn setTitle:@"立即报名(¥299)" forState:UIControlStateNormal];
            self.rightBtn.tag = 1003;
        } else if ([self.comment.type isEqualToString:@"1"]) { // 免费的未报名
            [self.rightBtn setTitle:@"立即报名" forState:UIControlStateNormal];
            self.rightBtn.tag = 1004;
        } else { // 已报名
            self.hidden = YES;
        }
    }
}

/*** 电话咨询 ***/
- (IBAction)phoneCallTaskButtonClick:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ServicePhone]];
}

/*** 右边按钮点击 ***/
- (IBAction)applyButtonClick:(UIButton *)sender
{
    if (sender.tag == 1000) {
        [self.rightBtn setTitle:@"进入学习(¥299)" forState:UIControlStateNormal];
        self.rightBtn.tag = 1001;
    } else if (sender.tag == 1001) {
        [self paymentButtonClick];

    } else if (sender.tag == 1002) {
        NDLog(@"去学习");
    } else if (sender.tag == 1003 || sender.tag == 1004) {
        
        NDDetailsController *detailsVC = (NDDetailsController *)[sender currentViewController];
        NDApplyViewController *applyVC = [[NDApplyViewController alloc] init];
        applyVC.index = sender.tag;
        [detailsVC.navigationController pushViewController:applyVC animated:YES];
    }
}

/*** 支付 ***/
- (void)paymentButtonClick
{
    self.paymentView = [[NDPaymentView alloc] initWithPaymentInfo:@"2019中医专长考前全真模拟卷2019中医专长考前全真模拟卷" paymentMoney:@"¥ 3000.00" paymentManner:0];
    
    [self.paymentView show];
}
@end
