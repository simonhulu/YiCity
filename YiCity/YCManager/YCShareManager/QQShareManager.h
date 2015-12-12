//
//  QQShareManager.h
//  Test
//
//  Created by szhang on 27/11/2015.
//  Copyright © 2015 hezi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "YCCommonManager.h"
typedef NS_ENUM(NSInteger, QQScene)
{
  QQ,
  QZONE
};
@interface QQShareManager : YCCommonManager
+(QQShareManager *)sharedManager ;
-(void)registerApp:(NSString *)appID ;
+(QQBaseReq *)QQNewsReq:(NSString *)htmlUrl htmlTitle:(NSString *)htmlTitle htmlDescription:(NSString *)htmlDescription previewImageUrl:(NSString *)previewImageUrl ;
-(BOOL)sendReq:(QQBaseReq *)req scene:(QQScene)scene ;
@end
