//
//  NDPlayerSlider.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/30.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDPlayerSlider.h"

#define SLIDER_X_BOUND 30
#define SLIDER_Y_BOUND 40

@interface NDPlayerSlider ()
@property (nonatomic ,assign) CGRect lastBounds;
@end

@implementation NDPlayerSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupThumbImage];
    }
    return self;
}

- (void)setupThumbImage
{
    [self setThumbImage:[UIImage imageNamed:@"video_slider_thumb"] forState:UIControlStateHighlighted];
    [self setThumbImage:[UIImage imageNamed:@"video_slider_thumb"] forState:UIControlStateNormal];
    [self setMinimumTrackTintColor:NDColor(69, 133, 245)];
}

/*** 控制slider的宽和高 ***/
- (CGRect)trackRectForBounds:(CGRect)bounds
{
    [super trackRectForBounds:bounds];
    
    return CGRectMake(bounds.origin.x, bounds.origin.y, CGRectGetWidth(bounds), 2);
}

/*** 修改滑块位置 ***/
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 6 ;
    rect.size.width = rect.size.width + 12;
    CGRect result = [super thumbRectForBounds:bounds trackRect:rect value:value];
    
    _lastBounds = result;
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result) {
        if ((point.x >= (_lastBounds.origin.x - SLIDER_X_BOUND)) && (point.x <= (_lastBounds.origin.x + _lastBounds.size.width + SLIDER_X_BOUND)) && (point.y >= -SLIDER_Y_BOUND) && (point.y < (_lastBounds.size.height + SLIDER_Y_BOUND))) {
            result = YES;
        }
    }
    return result;
}
@end
