//
//  WeiboManager.m
//  YiCity
//
//  Created by qizhang on 11/28/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "WeiboManager.h"

@implementation WeiboManager
static WeiboManager *singleton = nil ;
+(WeiboManager *)sharedManager
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        singleton = [[WeiboManager alloc]init];
    });
    return singleton ;
}

-(id)init
{
    self = [super init] ;
    if (self) {
        
    }
    
    return self ;
}
#pragma mark -
#pragma WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSLog(@"6");
//    NSString *jsonCode = [NSString stringWithFormat:@"%@(%@)",self.successFunction,authResp.code];
//    if ([self.delegate respondsToSelector:@selector(otherDidLogin:)]) {
//        [self.delegate otherDidLogin:jsonCode];
//    }
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *jsonCode = [NSString stringWithFormat:@"%@()",self.cancelFunction];
    if ([self.delegate respondsToSelector:@selector(otherDidLogin:)]) {
        [self.delegate otherDidLogin:jsonCode];
    }
}

-(void)login
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"http://yicity.com/api/weibo/authorize";
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}
-(void)registerApp:(NSString *)appID
{
    //    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:appID andDelegate:self] ;
}

-(BOOL)sendReq:(WBBaseRequest *)req
{
    return   [WeiboSDK sendRequest:req] ;
}

+(WBBaseRequest *)WeiboPageReq:(NSString *)htmlUrl title:(NSString *)title description:(NSString *)description
{
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = NSLocalizedString(title, nil);
    webpage.description = [NSString stringWithFormat:NSLocalizedString(@"'%@'", nil),description];
    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"yicityLogo" ofType:@"jpg"]];
    webpage.webpageUrl = htmlUrl;
    message.mediaObject = webpage;
    WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:message] ;
    return req ;
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response;
{
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
            WBAuthorizeResponse *authResponse = (WBAuthorizeResponse *)response ;
                    NSString *jsonCode = [NSString stringWithFormat:@"%@('%@');",self.successFunction,authResponse.userID] ;
            if ([self.delegate respondsToSelector:@selector(otherDidLogin:)]) {
                [self.delegate otherDidLogin:jsonCode];
            }
        }

    }else{
        if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
                    NSString *jsonCode = [NSString stringWithFormat:@"%@();",self.cancelFunction];
                    if ([self.delegate respondsToSelector:@selector(otherDidLoginFaild:)]) {
                        [self.delegate otherDidLogin:jsonCode];
                    }
        }


    }
}

@end
