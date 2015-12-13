//
//  YCTabBarController.m
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCTabBarController.h"
#import "YCWebViewController.h"
@implementation YCTabBarController

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self ;
    }
    return self ;
}
- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    // Is this the view controller type you are interested in?
    if ([viewController isKindOfClass:[YCWebViewController class]])
    {
        // call appropriate method on the class, e.g. updateView or reloadView
        [(YCWebViewController *) viewController reload];
    }
}
@end
