//
//  NDPlayerConfig.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/30.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDPlayerConfig.h"

@implementation NDPlayerConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hideControlsInterval = 5.0f;
    }
    return self;
}
@end
