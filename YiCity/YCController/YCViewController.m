//
//  YCViewController.m
//  YiCity
//
//  Created by qizhang on 11/22/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCViewController.h"
#import "YCHeaderBar.h"
@implementation YCViewController
-(id)init
{
    self = [super init];
    if (self) {
        _headerBar = [[YCHeaderBar alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        _headerBar.leftButton = leftButton ;
        _headerBar.rightButton = rightButton ;
        [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return  self ;
}

-(void)leftButtonClick:(id)sender
{
    [self leftButtonClick] ;
}

-(void)rightButtonClick:(id)sender
{
    [self rightButtonClick] ;
}

#pragma mark HeaderBar delegate
-(void)leftButtonClick
{
    
}

-(void)rightButtonClick
{
    
}

-(void)viewDidLoad
{
    [super viewDidLoad] ;
    [self.view addSubview:_headerBar];
}




-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - NavgationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
}
@end
