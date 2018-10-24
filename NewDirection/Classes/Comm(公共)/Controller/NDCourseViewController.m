//
//  NDCourseViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDCourseViewController.h"

@interface NDCourseViewController ()

@end

@implementation NDCourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"线上课程";
    
    if (!self.isUpload) return;
    [self setupHeaderView:@"course_top"];
}

- (NDSegmentedType)type
{
    return NDSegmentedTypeCourse;
}
@end
