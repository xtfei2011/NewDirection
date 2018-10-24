//
//  NDRefreshFooter.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDRefreshFooter.h"

@implementation NDRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor grayColor];
    self.stateLabel.font = NDCommodityTitleFont;
    
    [self setTitle:@"--- 没有更多啦 ---" forState:MJRefreshStateNoMoreData];
}
@end
