//
//  YCCommonManager.h
//  YiCity
//
//  Created by qizhang on 12/5/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCWebViewController.h"
@interface YCCommonManager : NSObject<YCThirdLoginDelegate>
-(BOOL)login;
@property(nonatomic,strong)NSString *cancelFunction ;
@property(nonatomic,strong)NSString *successFunction ;
@property(nonatomic,weak) id<YCThirdLoginDelegate>delegate ;
@end
