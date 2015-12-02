//
//  YCShareManager.h
//  Test
//
//  Created by szhang on 27/11/2015.
//  Copyright © 2015 hezi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCShareManager : NSObject
+(YCShareManager *)sharedManager ;
+(void)registerApp ;
+(BOOL)sendReq:(NSObject *)req ;
@end
