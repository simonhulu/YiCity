//
//  BaiduMobStatAppDelegate.m
//  BaiduMobStatSample
//
//  Created by Lidongdong on 15/7/22.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "BaiduMobStatAppDelegate.h"
#import "BaiduMobStat.h"
#import "MyPageLogViewController.h"

@implementation BaiduMobStatAppDelegate

/**
 *  初始化百度统计SDK
 */
- (void)startBaiduMobStat {
    /*若应用是基于iOS 9系统开发，需要在程序的info.plist文件中添加一项参数配置，确保日志正常发送，配置如下：
        NSAppTransportSecurity(NSDictionary):
            NSAllowsArbitraryLoads(Boolen):YES
      详情参考本Demo的BaiduMobStatSample-Info.plist文件中的配置
     */
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    // 此处(startWithAppId之前)可以设置初始化的可选参数，具体有哪些参数，可详见BaiduMobStat.h文件，例如：
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.enableDebugOn = YES;
    
    [statTracker startWithAppId:@"3af6b6bd84"]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化百度统计SDK
    [self startBaiduMobStat];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    MyPageLogViewController* v1 = [[MyPageLogViewController alloc] init];
    v1.title = @"Tab1";
    UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:v1];
    MyPageLogViewController* v2 = [[MyPageLogViewController alloc] init];
    v2.title = @"Tab2";
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:v2];
    MyPageLogViewController* v3 = [[MyPageLogViewController alloc] init];
    v3.title = @"Tab3";
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:v3];
    MyPageLogViewController* v4 = [[MyPageLogViewController alloc] init];
    v4.title = @"Tab4";
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:v4];
    NSArray* items =[NSArray arrayWithObjects:nv1, nv2, nv3, nv4, nil];
    tabbarController.viewControllers = items;
    tabbarController.delegate = self;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
