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
    webpage.description = [NSString stringWithFormat:NSLocalizedString(@"%@", nil),description];
    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"yicityLogo" ofType:@"jpg"]];
    webpage.webpageUrl = htmlUrl;
    message.mediaObject = webpage;
    WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:message] ;
    return req ;
}
@end
