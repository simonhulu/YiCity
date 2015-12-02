//
//  YCNavigationController.m
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCNavigationController.h"
#import "YCWebViewController.h"
@implementation YCNavigationController


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[YCWebViewController class]]) {
        YCWebViewController *webController = (YCWebViewController *)viewController ;
        webController.showBackButton = YES ;
    }
    [super pushViewController:viewController animated:animated] ;
}
@end
