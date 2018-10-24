//
//  TFSetCommonItem.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFSetCommonItem : NSObject
/*** 图标 ***/
@property (nonatomic ,copy) NSString *icon;
/*** 标题 ***/
@property (nonatomic ,copy) NSString *title;
/*** 子标题 ***/
@property (nonatomic ,copy) NSString *subtitle;
/*** 右边显示的数字标记 ***/
@property (nonatomic ,copy) NSString *badgeValue;
/*** 点击这行cell，需要调转到哪个控制器 ***/
@property (nonatomic ,assign) Class destVcClass;
/*** 封装点击这行cell想做的事情 ***/
@property (nonatomic ,copy) void (^operation)(void);

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
