//
//  YCWebViewController.h
//  YiCity
//
//  Created by qizhang on 11/21/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "YCWebView.h"
#import "YCViewController.h"
@interface YCWebViewController : YCViewController
- (instancetype)initWithAddress:(NSString *)urlString ;

- (instancetype)initWithURL:(NSURL*)pageURL ;
- (instancetype)initWithURLRequest:(NSURLRequest*)request ;
@property (nonatomic, weak) id<UIWebViewDelegate> delegate;
@property(nonatomic,assign)BOOL showBackButton ;
@property(nonatomic,assign)BOOL isRoot ;

@end
