//
//  NDCountDownButton.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDCountDownButton : UIButton
/*** 倒计时长 ***/
@property (nonatomic ,assign) NSInteger started;
/*** 原始颜色 ***/
@property (nonatomic ,strong) UIColor *originalColor;
/*** 倒计时颜色 ***/
@property (nonatomic ,strong) UIColor *processColor;
@end
