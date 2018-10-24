//
//  NDSearchView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSearchView.h"

@interface NDSearchView ()

@property (nonatomic ,strong) UIView *baseView;
@property (nonatomic ,strong) UIImageView *searchIcon;
@end

@implementation NDSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = NDColor(247, 248, 250);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
        
        [self setupSearchView];
    }
    return self;
}

- (void)setupSearchView
{
    self.baseView = [[UIView alloc] initWithFrame:self.bounds];
    self.baseView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.baseView];
    
    self.searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
    self.searchIcon.image = [UIImage imageNamed:@"nav_search"];
    [self.baseView addSubview:self.searchIcon];
    
    self.searchField = [[NDTextField alloc] initWithFrame:CGRectMake(40, 0, self.baseView.xtfei_width - 50, 30)];
    self.searchField.placeholder = @"输入关键词···";
    self.searchField.textColor = NDColor(30, 44, 74);
    self.searchField.font = NDCommentTitleFont;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchField.returnKeyType = UIReturnKeySearch;
    [self.baseView addSubview:self.searchField];
}

@end
