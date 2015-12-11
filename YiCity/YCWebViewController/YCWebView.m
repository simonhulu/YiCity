//
//  YCWebView.m
//  YiCity
//
//  Created by qizhang on 11/21/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCWebView.h"

@implementation YCWebView
#pragma mark - Setters

- (void)setNavDelegate:(id<YCWebNavigationDelegate>)delegate
{
    if (!delegate || (self.navDelegate && ![self.navDelegate isEqual:delegate])) {
        [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    }
    
    if (delegate) {
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];
    }
    
    _navDelegate = delegate;
    
    [super setNavigationDelegate:delegate];
}

#pragma mark - Key Value Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isEqual:self] && [keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))])
    {
        if (self.navDelegate && [self.navDelegate respondsToSelector:@selector(webView:didUpdateProgress:)]) {
            [self.navDelegate webView:self didUpdateProgress:self.estimatedProgress];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(WKNavigation *)loadRequest:(NSURLRequest *)request
{
   // NSURLRequest *lRequest = [NSURLRequest requestWithURL:@"http://www.baidu.com/"];
   return  [super loadRequest:request];
}

@end
