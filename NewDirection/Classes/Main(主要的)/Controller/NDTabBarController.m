//
//  NDTabBarController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDTabBarController.h"
#import "NDNavigationController.h"
#import "NDHomeViewController.h"
#import "NDStoreViewController.h"
#import "NDConsultViewController.h"
#import "NDMineViewController.h"

@interface NDTabBarController ()

@end

@implementation NDTabBarController

+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = NDColor(83, 134, 237);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    [self setupChildViewController:[[NDHomeViewController alloc] init] title:@"首页" image:@"tab_bar_home" selectedImage:@"tab_bar_home_selected"];
    
    [self setupChildViewController:[[NDStoreViewController alloc] init] title:@"学习" image:@"tab_bar_mall" selectedImage:@"tab_bar_mall_selected"];
    
    [self setupChildViewController:[[NDConsultViewController alloc] init] title:@"咨询" image:@"tab_bar_consult" selectedImage:@"tab_bar_consult_selected"];
    
    [self setupChildViewController:[[NDMineViewController alloc] init] title:@"我的" image:@"tab_bar_me" selectedImage:@"tab_bar_me_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param viewController            子控制器
 *  @param title                     标题
 *  @param image                     图标
 *  @param selectedImage             选中的图标
 */
- (void)setupChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.view.backgroundColor = NDCommonBgColor;
    
    /*** 给外面传进来的控制器包装导航控制器 ***/
    NDNavigationController *nav = [[NDNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}
@end
