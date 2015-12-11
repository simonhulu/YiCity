//
//  YCShareViewController.m
//  YiCity
//
//  Created by qizhang on 11/28/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCShareViewController.h"

@interface YCShareViewController ()
//@property(nonatomic,strong)UIView *sharePanel ;
//@property(nonatomic,strong)UIGestureRecognizer *backgroudGesture;
//@property(nonatomic,strong)UIView *backgroudView ;
@end

@implementation YCShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
     //   _backgroudView = [[UIView alloc]initWithFrame:CGRectZero];

    //[self.view addSubview:_backgroudView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(action:)];
    tapGesture.delegate = self ;
    [self.view addGestureRecognizer:tapGesture];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    [button setTitle:@"12" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(tAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    _backgroudView.frame = self.view.frame ;
//    _backgroudView.layer.borderColor = [UIColor redColor].CGColor ;
//    _backgroudView.layer.borderWidth = 1 ;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _backgroudGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
//    _backgroudView.userInteractionEnabled = YES ;
//    
//    [_backgroudView addGestureRecognizer:_backgroudGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tAction:(id)sender
{
    NSLog(@"Touched") ;
}

-(void)action:(UIGestureRecognizer *)recognizer
{
    NSLog(@"12");
}

-(void)showSharePanel
{
//    if (!_sharePanel) {
//        _sharePanel = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 300)];
//        
//    }
//    [UIView animateWithDuration:0.3f animations:^{
//        _sharePanel.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-300, CGRectGetWidth(self.view.frame), 300);
//        _backgroudView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
//    } completion:^(BOOL finished) {
//        
//    }];
}


-(void)hideSharePanel
{
//    if (_sharePanel) {
//        [UIView animateWithDuration:0.3f animations:^{
//            _sharePanel.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 300);
//            _sharePanel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
//        } completion:^(BOOL finished) {
//            [self.view removeFromSuperview];
//        }];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

@end
