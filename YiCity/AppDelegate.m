//
//  AppDelegate.m
//  YiCity
//
//  Created by qizhang on 11/21/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "AppDelegate.h"
#import "YCTabBarController.h"
#import "YCWebViewController.h"
#import "YCReceivePushMessageManager.h"
#import "YCNavigationController.h"
#import "WKProcessPoolManager.h"
#import "YCShareManager.h"
#import "EDColor.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "WXShareManager.h"
#import "QQShareManager.h"
#import "WeiboManager.h"
@interface AppDelegate ()
{
    UINavigationController *nav;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
//    viewController = [[ViewController alloc]init];
//    viewController.view.frame = self.window.bounds ;
//    viewController.view.backgroundColor = [UIColor whiteColor] ;
//    nav = [[UINavigationController alloc]initWithRootViewController:viewController];
//    nav.navigationBarHidden = YES ;
//    self.window.rootViewController = nav ;
    [YCShareManager registerApp] ;
    [[WKProcessPoolManager sharedManager] setUserAgent:^{
        
    }];
    YCTabBarController *tabBarController = [[YCTabBarController alloc]init];
    YCWebViewController *index = [[YCWebViewController alloc]initWithAddress:@"http://www.yicity.com"];
    UITabBarItem *indexBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"Home"] tag:0];
    index.tabBarItem = indexBarItem ;
    YCWebViewController *category = [[YCWebViewController alloc]initWithAddress:@"http://www.yicity.com/app/category.html"];
    UITabBarItem *categoryBarItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:[UIImage imageNamed:@"category"] tag:1];
    category.tabBarItem = categoryBarItem ;
    YCWebViewController *publish = [[YCWebViewController alloc]initWithAddress:@"http://www.yicity.com/ad/chooseCategory.html"];
    UITabBarItem *publishBarItem = [[UITabBarItem alloc]initWithTitle:@"发布" image:[UIImage imageNamed:@"create"] tag:2];
    publish.tabBarItem = publishBarItem ;
    YCWebViewController *userProfile = [[YCWebViewController alloc]initWithAddress:@"http://www.yicity.com/app/me.html"];
    UITabBarItem *userProfileBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"user"] tag:3];
    userProfile.tabBarItem = userProfileBarItem ;
    YCWebViewController *more = [[YCWebViewController alloc]initWithAddress:@"http://www.yicity.com/app/more.html"];
    UITabBarItem *moreBarItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"MoreInfo"] tag:4];
    more.tabBarItem = moreBarItem ;
    tabBarController.viewControllers = [NSArray arrayWithObjects:index,category,publish,userProfile,more, nil];
    [tabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithHexString:@"#FD5E0F"]] ;
    tabBarController.tabBar.backgroundColor = [UIColor  colorWithHexString:@"#eeeeee"] ;
    YCNavigationController *navController = [[YCNavigationController alloc]initWithRootViewController:tabBarController];
    navController.navigationBarHidden = YES ;
    navController.interactivePopGestureRecognizer.enabled = NO ;
    self.window.rootViewController = navController ;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [YCReceivePushMessageManager sharedManager].deviceToken = [NSString stringWithUTF8String:[deviceToken bytes]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[WXShareManager sharedManager]] || [TencentOAuth HandleOpenURL:url] || [WeiboSDK handleOpenURL:url delegate:[WeiboManager sharedManager]];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:[WXShareManager sharedManager]] || [TencentOAuth HandleOpenURL:url] || [WeiboSDK handleOpenURL:url delegate:[WeiboManager sharedManager]] ;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
