//
//  WXShareManager.m
//  YiCity
//
//  Created by qizhang on 11/28/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "WXShareManager.h"
#import "WXApi.h"
@implementation WXShareManager
static WXShareManager *singleton = nil ;
+(WXShareManager *)sharedManager
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        singleton = [[WXShareManager alloc]init];
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

-(void)registerApp:(NSString *)appID
{
//    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:appID andDelegate:self] ;
}

-(BOOL)sendReq:(SendMessageToWXReq *)req
{
  return   [WXApi sendReq:req] ;
}

+(SendMessageToWXReq *)WXPageReq:(NSString *)htmlUrl title:(NSString *)title description:(NSString *)description
{
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = htmlUrl;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaObject = ext;
    message.messageExt = nil;
    message.messageAction = nil;
    message.mediaTagName = @" ";
    [message setThumbImage:[UIImage imageNamed:@"yicityLogo"]];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init] ;
    req.scene = WXSceneTimeline;
    req.message = message;
    return req ;
}

-(void)login
{
//    [WXApiRequestHandler sendAuthRequestScope: kAuthScope
//                                        State:kAuthState
//                                       OpenID:kAuthOpenID
//                             InViewController:self];
}
@end
