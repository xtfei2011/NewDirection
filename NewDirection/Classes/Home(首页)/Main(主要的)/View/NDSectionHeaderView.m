//
//  NDSectionHeaderView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/25.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSectionHeaderView.h"
#import "NDHomeViewController.h"

@interface NDSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subheadLabel;
@end

@implementation NDSectionHeaderView

#define SectionHeaderTitleArray @[@"直播教室" ,@"推荐课程" ,@"推荐书籍"]

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSection:(NSInteger)section
{
    _section = section;
    if (section == 0) return;
    
    self.subheadLabel.text = (section == 1) ? @"直播教室" : @"查看全部";
    self.titleLabel.text = SectionHeaderTitleArray[section - 1];
}

- (IBAction)evenMoreButtonClick:(UIButton *)sender
{
    NDHomeViewController *homeVC = (NDHomeViewController *)[sender currentViewController];
    
    UIViewController *viewClass = [[NSClassFromString(HomeMoreControllerArray[self.section - 1]) alloc] init];
//    if (indexPath.row != 1) {
//        [viewClass setValue:@YES forKey:@"isUpload"];
//    }
    [homeVC.navigationController pushViewController:viewClass animated:YES];
}

@end
