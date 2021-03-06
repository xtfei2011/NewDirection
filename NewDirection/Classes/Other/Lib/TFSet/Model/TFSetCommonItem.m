//
//  TFSetCommonItem.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "TFSetCommonItem.h"

@implementation TFSetCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    TFSetCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}
@end
