//
//  YCRootNavigationControllerManager.h
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCNavigationController.h"
@interface YCRootNavigationControllerManager : NSObject<UINavigationControllerDelegate>
+ (id)sharedManager;
@property (nonatomic,strong,readonly)YCNavigationController *navController ;
@end
