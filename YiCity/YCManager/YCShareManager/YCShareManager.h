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

@property(nonatomic,strong)NSString *shareDescription ;
@property(nonatomic,strong)NSString *shareIconUrl ;
@property(nonatomic,strong)NSString *shareTitle ;
@property(nonatomic,strong)NSString *shareRedirectURL ;
@end
