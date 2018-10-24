//
//  NDCityPickerView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/12.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCityPickerView.h"

@interface NDCityPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic ,strong) UIPickerView *bountyView;
@property (nonatomic ,strong) UIView *markView;
@property (nonatomic ,strong) UIButton *cancelBtn;
@property (nonatomic ,strong) UIButton *completionBtn;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) NSMutableArray *array;
@property (nonatomic ,copy) NSString *selectedStr;

@end

@implementation NDCityPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.frame = NDScreeFrame;
        self.backgroundColor = NDRGBColor(5, 5, 5, 0.3);
        
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.markView = [[UIView alloc] initWithFrame:CGRectMake(0, NDMainScreen_Height, NDMainScreen_Width, NDMainScreen_Height/3)];
    self.markView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.markView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(0, 0, 60, 44);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = NDCommentTitleFont;
    [self.cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.markView addSubview:self.cancelBtn];
    
    self.completionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.completionBtn.frame = CGRectMake(self.xtfei_width - 60, 0, 60, 44);
    [self.completionBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.completionBtn.titleLabel.font = NDCommentTitleFont;
    [self.completionBtn setTitleColor:NDColor(86, 86, 255) forState:UIControlStateNormal];
    [self.completionBtn addTarget:self action:@selector(completionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.markView addSubview:self.completionBtn];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cancelBtn.frame), NDMainScreen_Width, 0.5)];
    self.lineView.backgroundColor = NDGrayColor(224);
    [self.markView addSubview:self.lineView];
    
    [self showAnimation];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.cityArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.cityArr[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    
    if (!pickerLabel) {
        
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedStr = self.cityArr[row];
}

- (void)setCityArr:(NSArray *)cityArr
{
    _cityArr = cityArr;
    
    self.bountyView = [UIPickerView new];
    self.bountyView.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), NDMainScreen_Width, self.markView.xtfei_height - 44);
    self.bountyView.delegate = self;
    self.bountyView.dataSource = self;
    [self.array addObject:cityArr];
    [self.markView addSubview:self.bountyView];
}

#pragma mark-----取消
- (void)cancelBtnClick
{
    [self hideAnimation];
}

#pragma mark-----确定
- (void)completionBtnClick
{
    NSString *str = [self.cityArr objectAtIndex:[self.bountyView selectedRowInComponent:0]];
    
    if (self.cityPickerBlock) {
        self.cityPickerBlock(str);
    }
    [self hideAnimation];
}

#pragma mark-----隐藏的动画
- (void)hideAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.markView.frame;
        frame.origin.y = NDMainScreen_Height;
        self.markView.frame = frame;
    } completion:^(BOOL finished) {
        
        [self.markView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark-----显示的动画
- (void)showAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.markView.frame;
        frame.origin.y = NDMainScreen_Height *2/3;
        self.markView.frame = frame;
    }];
}

@end
