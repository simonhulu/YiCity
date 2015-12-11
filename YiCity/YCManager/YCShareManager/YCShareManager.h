//
//  YCShareManager.h
//  Test
//
//  Created by szhang on 27/11/2015.
//  Copyright © 2015 hezi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WXAPPID @"wxbb74970568b02ab4"
#define WEIBOAPPID @"807758488"
#define QQAPPID @"1104910915"
@interface YCShareManager : NSObject
+(YCShareManager *)sharedManager ;
+(BOOL)sendReq:(NSObject *)req ;
+(void)registerApp ;
@end
