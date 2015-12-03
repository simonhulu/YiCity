//
//  WKProcessPoolManager.m
//  YiCity
//
//  Created by qizhang on 11/25/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "WKProcessPoolManager.h"
#import "YCReceivePushMessageManager.h"
@implementation WKProcessPoolManager
+(WKProcessPoolManager *)sharedManager {
    static WKProcessPoolManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)setUserAgent:(void(^)())hander
{

    NSString *myuserAgent = [NSString stringWithFormat:@" %@=%@,%@=%@,%@=%@",@"yicity-user-agent",@"app-ios",@"yc-did",[YCReceivePushMessageManager sharedManager].deviceToken,@"yc-ver",[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newUserAgent = [userAgent stringByAppendingString:myuserAgent];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
