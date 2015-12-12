//
//  YCShareVIew.m
//  YiCity
//
//  Created by qizhang on 12/12/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCShareVIew.h"
@interface YCShareView()
@property(nonatomic,strong)UIButton *btn ;
@property(nonatomic,strong)UILabel *shareName ;
@property(nonatomic,copy)NSString *name ;
@end
@implementation YCShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithShareStyle:(UIButton *)btn name:(NSString *)name
{
        self = [super init];
        if(self)
        {
            _btn =btn ;
            _name = name ;
            [self setup] ;
            return self;
        }
    return self ;
}

-(void)setup
{
    _btn.frame = CGRectMake(0, 0, 45, 45);
    _shareName = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 45, 20)];
    _shareName.text = _name ;
    _shareName.textAlignment = NSTextAlignmentCenter ;
    _shareName.font = [UIFont systemFontOfSize:10];
    self.frame = CGRectMake(0, 0, 65, 65);
    [self addSubview:_btn];
    [self addSubview:_shareName];
}

-(void)setFrame:(CGRect)frame
{
    CGRect nFrame = CGRectMake(frame.origin.x, frame.origin.y, 65, 65) ;
    [super setFrame:nFrame] ;
}


@end
