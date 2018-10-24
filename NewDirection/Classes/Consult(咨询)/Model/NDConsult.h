//
//  NDConsult.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/8.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

/*** WebView 枚举 ***/
typedef NS_ENUM(NSUInteger, NDWebViewType) {
    
    /*** 咨询 ***/
    NDWebViewTypeConsult = 0,
    /*** 其他 ***/
    NDWebViewTypeOther = 1,
};

@interface NDConsult : NSObject

@end
