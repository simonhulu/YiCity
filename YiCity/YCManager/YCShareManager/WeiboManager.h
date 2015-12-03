//
//  WeiboManager.h
//  YiCity
//
//  Created by qizhang on 11/28/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
@interface WeiboManager : NSObject<WeiboSDKDelegate>
+(WeiboManager *)sharedManager ;
-(void)registerApp:(NSString *)appID ;
+(WBBaseRequest *)WeiboPageReq:(NSString *)htmlUrl title:(NSString *)title description:(NSString *)description ;
-(BOOL)sendReq:(WBBaseRequest *)req ;
@end
