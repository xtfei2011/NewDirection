//
//  NDCultivateViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCultivateViewController.h"
#import "NDCityPickerView.h"

@interface NDCultivateViewController ()

@property (nonatomic ,strong) NSString *address;
@end

@implementation NDCultivateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"面授培训";
    
    if (!self.isUpload) return;
    [self setupHeaderView:@"train_top"];
    self.address = @"面授地址";
}

- (void)clickAddressButton
{
    NDCityPickerView *cityView = [[NDCityPickerView alloc]initWithFrame:self.view.bounds];
    cityView.cityArr = @[@"北京" ,@"上海" ,@"深圳" ,@"广州" ,@"武汉"];
    
    cityView.cityPickerBlock = ^(NSString * _Nonnull city) {
        self.address = city;
    };
    [NDkeyWindowView addSubview:cityView];
}

- (void)setAddress:(NSString *)address
{
    _address = address;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:address style:UIBarButtonItemStyleDone target:self action:@selector(clickAddressButton)];
}

- (NDSegmentedType)type
{
    return NDSegmentedTypeCultivate;
}
@end
