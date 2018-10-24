//
//  NDStore.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

/*** 公共分段枚举 ***/
typedef NS_ENUM(NSUInteger, NDSegmentedType) {
    
    /*** 线上课程 ***/
    NDSegmentedTypeCourse = 0,
    /*** 直播课程 ***/
    NDSegmentedTypeLive = 1,
    /*** 面授培训 ***/
    NDSegmentedTypeCultivate = 2,
    /*** 图书资料 ***/
    NDSegmentedTypeMaterial = 3,
};

@interface NDStore : NSObject

@end
