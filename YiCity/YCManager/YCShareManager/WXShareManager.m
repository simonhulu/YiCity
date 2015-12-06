//
//  WXShareManager.m
//  YiCity
//
//  Created by qizhang on 11/28/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "WXShareManager.h"
#import "WXApi.h"
#import "YCShareManager.h"
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

-(BOOL)login
{
    SendAuthReq* req = [[SendAuthReq alloc] init] ;
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
    req.state = @"yc";
    req.openID = WEIBOAPPID;
    
    return [WXApi sendReq:req];
}

-(void)onResp:(BaseResp *)resp
{
   if ([resp isKindOfClass:[SendAuthResp class]])
   {
       if (resp.errCode != 0) {
           NSString *jsonCode = [NSString stringWithFormat:@"%@();",self.cancelFunction];
           if ([self.delegate respondsToSelector:@selector(otherDidLogin:)]) {
               [self.delegate otherDidLogin:jsonCode];
           }
       }else
       {
           SendAuthResp *authResp = (SendAuthResp *)resp;
           NSString *jsonCode = [NSString stringWithFormat:@"%@('%@');",self.successFunction,authResp.code];
           if ([self.delegate respondsToSelector:@selector(otherDidLogin:)]) {
               [self.delegate otherDidLogin:jsonCode];
           }
       }

   }
}
@end
