//
//  NDNavigationController.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDNavigationController.h"

@interface NDNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NDNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*** 设置导航控制器为手势识别器的代理 ***/
    self.interactivePopGestureRecognizer.delegate = self;
    
    /*** 设置导航栏默认的背景颜色 ***/
    [TFNavigationBar xtfei_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
    /*** 导航栏底部分割线隐藏 ***/
    [TFNavigationBar xtfei_setDefaultNavBarShadowImageHidden:YES];
    /*** 设置状态栏样式 ***/
    [TFNavigationBar xtfei_setDefaultStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Heiti SC" size:18], NSFontAttributeName, nil]];
}

/**
 *  重写push方法的目的 : 拦截所有push进来的子控制器
 *
 *  @param viewController 刚刚push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"back_arrow" highImage:nil target:self action:@selector(back)];
        viewController.view.backgroundColor = NDCommonBgColor;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *
 *  @return YES : 手势有效, NO : 手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

@end
