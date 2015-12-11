//
//  QQShareManager.m
//  Test
//
//  Created by szhang on 27/11/2015.
//  Copyright © 2015 hezi. All rights reserved.
//

#import "QQShareManager.h"


@interface QQShareManager()<TencentSessionDelegate>
@property (nonatomic,strong)TencentOAuth *tencentOAuth ;
@end

@implementation QQShareManager
static QQShareManager *singleton = nil ;
+(QQShareManager *)sharedManager
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        singleton = [[QQShareManager alloc]init];
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
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:appID andDelegate:self] ;
}

-(BOOL)sendReq:(QQBaseReq *)req
{
    if (_tencentOAuth) {
        QQApiSendResultCode code = [QQApiInterface SendReqToQZone:req] ;
        if (code == EQQAPISENDSUCESS) {
            return YES ;
        }else
        {
            return NO ;
        }
    }else
    {
        return  NO ;
    }
}

+(QQBaseReq *)QQNewsReq:(NSString *)htmlUrl htmlTitle:(NSString *)htmlTitle htmlDescription:(NSString *)htmlDescription previewImageUrl:(NSString *)previewImageUrl
{
    if (htmlUrl == nil) {
        return nil ;
    }
    NSURL *htmlURL = [NSURL URLWithString:htmlUrl] ;
    NSURL *preViewImageURL = [NSURL URLWithString:previewImageUrl] ;
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:htmlURL title:htmlTitle description:htmlDescription previewImageURL:preViewImageURL];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj ] ;
    return req ;
}

-(BOOL)login
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    return [_tencentOAuth authorize:permissions inSafari:NO] ;
}

-(void)tencentDidLogin
{
    NSString *jsonCode = [NSString stringWithFormat:@"%@('%@')",self.successFunction,_tencentOAuth.openId];
    if (self.delegate && [self.delegate respondsToSelector:@selector(otherDidLogin:)]) {
        [self.delegate otherDidLogin:jsonCode];
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSString *jsonCode = [NSString stringWithFormat:@"%@()",self.cancelFunction];
    if ([self.delegate respondsToSelector:@selector(otherDidLoginFaild:)]) {
        [self.delegate otherDidLoginFaild:jsonCode];
    }
}

- (void)tencentFailedUpdate:(UpdateFailType)reason;
{
    NSString *jsonCode = [NSString stringWithFormat:@"%@()",self.cancelFunction];
    if ([self.delegate respondsToSelector:@selector(otherDidLoginFaild:)]) {
        [self.delegate otherDidLoginFaild:jsonCode];
    }
}

@end
