//
//  NDDBHandle.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDDBHandle : NSObject
/**
 *  根据参数去取数据
 */
+ (NSDictionary *)statusesWithParams:(NSDictionary *)params;

/**
 *  存储服务器数据到沙盒中
 *
 *  @param statuses 需要存储的数据
 */
+ (void)saveStatuses:(NSDictionary *)statuses param:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
