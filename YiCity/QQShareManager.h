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
@interface QQShareManager : NSObject
+(QQShareManager *)sharedManager ;
-(void)registerApp:(NSString *)appID ;
+(QQBaseReq *)QQNewsReq:(NSString *)htmlUrl htmlTitle:(NSString *)htmlTitle htmlDescription:(NSString *)htmlDescription previewImageUrl:(NSString *)previewImageUrl ;
-(BOOL)sendReq:(QQBaseReq *)req ;
@end
