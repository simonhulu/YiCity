//
//  YCHeaderBar.m
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCHeaderBar.h"

@implementation YCHeaderBar
-(id)init
{
    self = [super init];
    if (self) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _leftButton.frame = CGRectMake(0, 0, 45, 45);
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rightButton.frame = CGRectMake(CGRectGetWidth(self.frame)-45, 0, 45, 45) ;
        [_leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [self addSubview:_leftButton];
        [self addSubview:_rightButton];
    }
    return self ;
}
-(void)setLeftButton:(UIButton *)leftButton
{
    if (leftButton) {
        leftButton.frame = CGRectMake(0, 0, 45, 45);
    }
    _leftButton = leftButton ;
    [self addSubview:_leftButton];
}

-(void)setRightButton:(UIButton *)rightButton
{
    if (_rightButton) {
        rightButton.frame = CGRectMake(CGRectGetWidth(self.frame)-45, 0, 45, 45) ;
    }
    _rightButton = rightButton ;
    [self addSubview:_rightButton];
}

@end
