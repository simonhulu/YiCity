//
//  YCWebView.h
//  YiCity
//
//  Created by qizhang on 11/21/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@protocol YCWebNavigationDelegate;
@interface YCWebView : WKWebView
@property (nonatomic, weak) id <YCWebNavigationDelegate> navDelegate;
@end

@protocol YCWebNavigationDelegate <WKNavigationDelegate>

- (void)webView:(YCWebView *)webView didUpdateProgress:(CGFloat)progress;

@end