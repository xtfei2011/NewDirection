//
//  NDSetViewController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSetViewController.h"
#import "TFSetCommonGroup.h"
#import "TFSetCommonItem.h"
#import "TFSetCommonArrowItem.h"
#import "TFSetCommonLabelItem.h"
#import "TFSetCommonClearItem.h"
#import "NDExitView.h"

@interface NDSetViewController ()
@property (nonatomic ,strong) NDExitView *exitView;
@end

@implementation NDSetViewController

- (NDExitView *)exitView
{
    if (!_exitView) {
        
        _exitView = [NDExitView viewFromXib];
    }
    return _exitView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    [self setupGroups];
    
    self.tableView.tableFooterView = self.exitView;
}

- (void)setupGroups
{
    [self setupGroup0];
}

- (void)setupGroup0
{
    TFSetCommonGroup *group = [TFSetCommonGroup group];
    [self.groups addObject:group];
    
    TFSetCommonClearItem *clear = [TFSetCommonClearItem itemWithTitle:@"清理缓存"];
    
    TFSetCommonItem *about = [TFSetCommonArrowItem itemWithTitle:@"关于我们"];
    about.destVcClass = [UIViewController class];
    
    group.items = @[clear ,about];
}

@end
