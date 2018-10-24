//
//  NDBooksViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDBooksViewController.h"

@interface NDBooksViewController ()

@end

@implementation NDBooksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"图书资料";
    
    if (!self.isUpload) return;
    [self setupHeaderView:@"material_top"];
}

- (NDSegmentedType)type
{
    return NDSegmentedTypeMaterial;
}
@end
