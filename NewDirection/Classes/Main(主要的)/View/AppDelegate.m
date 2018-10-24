//
//  AppDelegate.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "AppDelegate.h"
#import "NDTabBarController.h"
#import "NDShareManager.h"
#import "NDNewfeatureController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    /*** 版本新特征 ***/
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [NDUSER_DEFAULTS objectForKey:key];
    /*** 当前软件的版本号（从Info.plist中获得） ***/
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];

    if ([currentVersion isEqualToString:lastVersion]) {
        self.window.rootViewController = [[NDTabBarController alloc] init];

    } else {
        /*** 这次打开的版本和上一次不一样，显示新特性 ***/
        self.window.rootViewController = [[NDNewfeatureController alloc] init];
        /*** 将当前的版本号存进沙盒 ***/
        [NDUSER_DEFAULTS setObject:currentVersion forKey:key];
        [NDUSER_DEFAULTS synchronize];
    }
    
    [self.window makeKeyAndVisible];
    
    /*** 友盟分享 ***/
    [NDShareManager setupShareAppKey];
    
    return YES;
}

/*** 分享回调方法 ***/
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    if ([[url host] isEqualToString:@"com.tencent.xin"]) {
//        return [WXApi handleOpenURL:url delegate:self];
//    } else {
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NDLog(@"result = %@",resultDic);
//        }];
//        if ([url.host isEqualToString:@"platformapi"]){ //支付宝钱包快登授权返回 authCode
//            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NDLog(@"result = %@",resultDic);
//            }];
//        }
//    }
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//
//    if (result == false) {
//    }
//    return result;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
