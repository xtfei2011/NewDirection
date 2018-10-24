//
//  TFSetCommonGroup.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/10.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFSetCommonGroup : NSObject
/*** 组头 ***/
@property (nonatomic ,copy) NSString *header;
/*** 组尾 ***/
@property (nonatomic ,copy) NSString *footer;
/*** 这组的所有行模型 ***/
@property (nonatomic ,strong) NSArray *items;

+ (instancetype)group;
@end
