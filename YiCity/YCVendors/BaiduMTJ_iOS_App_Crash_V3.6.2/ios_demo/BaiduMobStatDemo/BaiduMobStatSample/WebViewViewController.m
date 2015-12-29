//
//  WebViewViewController.m
//  BaiduMobStatSample
//
//  Created by Lidongdong on 15/7/22.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "WebViewViewController.h"
#import "BaiduMobStat.h"


@interface WebViewViewController ()<UIWebViewDelegate>

@end

@implementation WebViewViewController
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView * Web = [[UIWebView alloc] init];
    Web.delegate = self;
    Web.frame = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);
    Web.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:Web];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"mobstat" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [Web loadRequest:request];
}

//实现WebView的代理方法，并在此函数中调用SDK的webviewStartLoadWithRequest:传入request参数，进行统计
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [[BaiduMobStat defaultStat] webviewStartLoadWithRequest:request];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
