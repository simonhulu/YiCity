//
//  MyPageLogViewController.m
//  BaiduMobStatSample
//
//  Created by Lidongdong on 15/7/22.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "MyPageLogViewController.h"
#import "BaiduMobStat.h"
#import "WebViewViewController.h"

@implementation MyPageLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@",  self.tabBarItem.title, nil];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@", self.tabBarItem.title, nil];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    float y = 10.0;
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 150, 25)];
    label0.backgroundColor = [UIColor grayColor];
    label0.textColor = [UIColor whiteColor];
    label0.text = @"自定义事件统计";
    label0.font = [UIFont systemFontOfSize:13];
    label0.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label0];
    y += 35;
    
    UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(0, y, 160, 25);
    [btn1 setTitle:@"Event1" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn1 addTarget:self action:@selector(logEventClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    y += 35;
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(0, y, 160, 25);
    [btn2 setTitle:@"Event2 Start" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn2.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn2 addTarget:self action:@selector(logEventWithDurationTime:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    y += 35;
    
    UIButton* btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame = CGRectMake(0, y, 160, 25);
    [btn3 setTitle:@"Event3 (duration 1s)" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn3.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn3 addTarget:self action:@selector(logEventWithOneSeconde:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    y += 35;
    
    if ([self.title isEqualToString:@"Tab1"]) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 150, 25)];
        label1.backgroundColor = [UIColor grayColor];
        label1.textColor = [UIColor whiteColor];
        label1.text = @"webView行为统计";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:label1];
        y += 30;
        
        UIButton* btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn4.frame = CGRectMake(0, y, 160, 25);
        [btn4 setTitle:@"Into WebView" forState:UIControlStateNormal];
        [btn4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn4.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn4 addTarget:self action:@selector(intoWebView:) forControlEvents: UIControlEventTouchUpInside];
        [self.view addSubview:btn4];
        y += 35;
    }
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 150, 25)];
    label2.backgroundColor = [UIColor grayColor];
    label2.textColor = [UIColor whiteColor];
    label2.text = @"页面统计";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label2];
    y += 30;
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 150, 25)];
    label3.backgroundColor = [UIColor clearColor];
    label3.textColor = [UIColor grayColor];
    label3.text = @"切换Tab统计页面";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label3];
    y += 30;
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 150, 25)];
    label4.backgroundColor = [UIColor grayColor];
    label4.textColor = [UIColor whiteColor];
    label4.text = @"Exception统计";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label4];
    y += 30;
    
    UIButton* btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn5.frame = CGRectMake(0, y, 160, 25);
    [btn5 setTitle:@"触发异常崩溃" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn5.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn5 addTarget:self action:@selector(makeException:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    y += 35;
}

- (void)logEventClick:(id)sender {
    [[BaiduMobStat defaultStat] logEvent:@"Event1" eventLabel:@"sss"];
}

- (void)logEventWithDurationTime:(id)sender {
    if(!eventStatu) {
        eventStatu = YES;
        [(UIButton*) sender setTitle:@"Event2 End" forState:UIControlStateNormal];
        
        [[BaiduMobStat defaultStat] eventStart:@"Event2" eventLabel:@"sss"];
    } else {
        eventStatu = NO;
        [(UIButton*) sender setTitle:@"Event2 Start" forState:UIControlStateNormal];
        
        [[BaiduMobStat defaultStat] eventEnd:@"Event2" eventLabel:@"sss"];
    }
}

- (void)logEventWithOneSeconde:(id)sender {
    [[BaiduMobStat defaultStat] logEventWithDurationTime:@"Event3" eventLabel:@"sss" durationTime:1000];
}

- (void)intoWebView:(id)sender {
    WebViewViewController * webC = [[WebViewViewController alloc] init];
    [self.navigationController pushViewController:webC animated:YES];
}

- (void)makeException:(id)sender {
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"1", nil];
    [array1 objectAtIndex:2];
}

@end
