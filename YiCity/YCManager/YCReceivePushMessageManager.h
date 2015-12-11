//
//  YCReceivePushMessageManager.h
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCReceivePushMessageManager : NSObject
+(YCReceivePushMessageManager *)sharedManager;
@property(nonatomic,strong)NSString *deviceToken ;
@end
