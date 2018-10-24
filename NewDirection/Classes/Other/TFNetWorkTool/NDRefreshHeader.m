//
//  NDRefreshHeader.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDRefreshHeader.h"

@implementation NDRefreshHeader

/*** 初始化 ***/
- (void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
    self.stateLabel.textColor = [UIColor grayColor];
    self.stateLabel.font = self.lastUpdatedTimeLabel.font = NDCommodityTitleFont;
}

@end
