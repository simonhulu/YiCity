//
//  WXShareManager.h
//  YiCity
//
//  Created by qizhang on 11/28/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "YCCommonManager.h"
@interface WXShareManager : YCCommonManager<WXApiDelegate>
+(WXShareManager *)sharedManager ;
-(void)registerApp:(NSString *)appID ;
+(SendMessageToWXReq *)WXPageReq:(NSString *)htmlUrl title:(NSString *)title description:(NSString *)description ;
-(BOOL)sendReq:(SendMessageToWXReq *)req ;
-(BOOL)login;

@end
