//
//  YCHeaderBar.m
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCHeaderBar.h"
@interface YCHeaderBar()
{
    UILabel *_titleLabel ;
    NSMutableArray *_rightButtons ;
}
@end
@implementation YCHeaderBar
-(id)init
{
    self = [super init];
    if (self) {
        [self initila];
    }
    return self ;
}

-(void)initila
{
    _rightButtons = [NSMutableArray arrayWithCapacity:4];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _titleLabel.textAlignment = NSTextAlignmentCenter ;
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    _leftButton.frame = CGRectMake(0, 0, 45, 45);
    //_rightButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    //_rightButton.frame = CGRectMake(CGRectGetWidth(self.frame)-45, 0, 45, 45) ;
    [_leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //[_rightButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [self addSubview:_titleLabel ];
    [self addSubview:_leftButton];
    //[self addSubview:_rightButton];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initila];
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
    [_rightButtons addObject:_rightButton];
    [self addSubview:_rightButton];
}

-(void)addToRightButtons:(UIButton *)btn
{
    [self addSubview:btn];
    [_rightButtons addObject:btn];
    [self layoutHeaderRight] ;
}

-(void)layoutHeaderRight
{
    NSInteger addedButton = 0 ;
    for (NSInteger i = [_rightButtons count]-1 ; i>=0 ; i--) {
        addedButton++ ;
        UIButton *button = _rightButtons[i];
        button.frame = CGRectMake(CGRectGetWidth(self.frame) - addedButton*45, 0, 45, 45);
    }
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame] ;
    _titleLabel.frame = frame ;
}

-(void)setTitle:(NSString *)title
{
    _title = title ;
    _titleLabel.text = title ;
}

@end
