//
//  NDSearchReusableView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSearchReusableView.h"

@interface NDSearchReusableView ()

@property (nonatomic ,strong) UILabel *titleLabel;
@end

@implementation NDSearchReusableView

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0 ,10, 100, 40);
        titleLabel.font = NDPromptTitleFont;
        titleLabel.textColor = [UIColor grayColor];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UIButton *)delectBtn
{
    if (!_delectBtn) {
        
        UIButton *delectBtn = [[UIButton alloc] init];
        delectBtn.frame = CGRectMake(self.xtfei_width - 40 ,10, 40, 40);
        [delectBtn setImage:[UIImage imageNamed:@"search_delete"] forState:UIControlStateNormal];
        [delectBtn addTarget:self action:@selector(delectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _delectBtn = delectBtn;
    }
    return _delectBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.delectBtn];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)delectBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(delectButtonClick:)]) {
        [self.delegate delectButtonClick:self];
    }
}
@end
