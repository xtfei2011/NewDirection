//
//  NDCountDownButton.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCountDownButton.h"

@interface NDCountDownButton ()

@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,assign) NSInteger countDown;
@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,assign) int count;

@end

@implementation NDCountDownButton

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    if (self.countDown == self.started) {
        self.title = title;
        self.originalColor = self.titleLabel.textColor;
    }
}

- (void)setStarted:(NSInteger)started
{
    _started = started;
    self.countDown = started;
}

- (void)setOriginalColor:(UIColor *)originalColor
{
    _originalColor = originalColor;
    [self setTitleColor:originalColor forState:UIControlStateNormal];
}

- (void)setProcessColor:(UIColor *)processColor
{
    _processColor = processColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = NDCommentTitleFont;
        
        if (self.originalColor) {
            [self setTitleColor:self.originalColor forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        self.count = 0;
        self.started = 60;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.count = 0;
        self.started = 60;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.count ++;
    if (self.countDown != self.started || self.count != 1) {
        self.count = 0;
//        [TFProgressHUD showMessage:@"60秒内请不要重复操作"];
        return NO;
    }
    [self startCountDown];
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)startCountDown
{
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCountDownButtonTitle) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateCountDownButtonTitle
{
    if (self.countDown == 0) {
        
        [self setTitle:self.title forState:UIControlStateNormal];
        [self setTitleColor:self.originalColor forState:UIControlStateNormal];
        
        self.countDown = self.started;
        [self.timer invalidate];
        self.count = 0;
        
    } else {
        [self setTitle:[NSString stringWithFormat:@"重新发送(%zds)" ,self.countDown --] forState:UIControlStateNormal];
        
        if (self.processColor) {
            [self setTitleColor:self.processColor forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            self.layer.borderColor = [UIColor orangeColor].CGColor;
        }
    }
}
@end
