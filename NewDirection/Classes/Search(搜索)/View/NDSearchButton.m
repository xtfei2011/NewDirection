//
//  NDSearchButton.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSearchButton.h"

@implementation NDSearchButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSearchButton];
    }
    return self;
}

- (void)setupSearchButton
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitle:@" 搜索课程" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
    
    [self setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
}

@end
