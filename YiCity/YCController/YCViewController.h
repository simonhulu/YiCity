//
//  YCViewController.h
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHeaderBar.h"

@interface YCViewController : UIViewController<UINavigationControllerDelegate,YCHeaderBarOperation>
@property(nonatomic,strong)YCHeaderBar *headerBar;
@end
