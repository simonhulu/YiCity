//
//  YCWebViewController.m
//  YiCity
//
//  Created by qizhang on 11/21/15.
//  Copyright (c) 2015 hezi. All rights reserved.
//

#import "YCWebViewController.h"
#import "EDColor.h"
#import "YCReceivePushMessageManager.h"
#import "WKProcessPoolManager.h"
#import "YCShareViewController.h"
#import "AppDelegate.h"
#import "QQShareManager.h"
#import "YCShareManager.h"
#import "WXShareManager.h"
#import "YCHTMLButton.h"
#import "WeiboSDK.h"
#import "WeiboManager.h"
#import "UIAlertView+Blocks.h"
#import "UIButton+AFNetworking.h"
@interface YCWebViewController()<UIWebViewDelegate,WKUIDelegate,YCWebNavigationDelegate,UITableViewDataSource, UITableViewDelegate,WKScriptMessageHandler,YCThirdLoginDelegate>
{
    BOOL linkCliked ;
}
@property(nonatomic,strong) YCWebView *webView ;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) UIProgressView *progressView;
@property(nonatomic,strong) UIButton *shareBtn ;
@property(nonatomic,strong) UIView *shareView ;
@property(nonatomic,strong) UIView *sharePanel ;
@property(nonatomic,strong) UIButton *qqButton ;
@property(nonatomic,strong) UIButton *wxButton ;
@property(nonatomic,strong) UIButton *weiboButton ;
@property(nonatomic,strong) UIButton *sharePanelBackBtn ;
@property(nonatomic,strong) YCHTMLButton *createRButton ;
@property(nonatomic,strong) UIButton *callButton ;
@property(nonatomic,strong) NSMutableArray *indexdArray ;
@property(nonatomic,strong) NSString *jsUrl ;
@property(nonatomic,strong) UISwipeGestureRecognizer *leftSwipGesture ;
@property(nonatomic,strong) UISwipeGestureRecognizer *rightSwipGesture ;
@end
@implementation YCWebViewController

#pragma mark - Initialization
-(void)dealloc
{
    [self.webView stopLoading] ;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.delegate = nil ;
    self.webView.navDelegate = nil ;
    self.webView.UIDelegate = nil ;
    [_shareBtn removeTarget:self action:@selector(showShareView:) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)initWithAddress:(NSString *)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL*)pageURL {
    return [self initWithURLRequest:[NSURLRequest requestWithURL:pageURL]];
}

- (instancetype)initWithURLRequest:(NSURLRequest*)request {
    self = [self init];
    if (self) {
        self.request = request;
    }
    return self;
}

- (void)loadRequest:(NSURLRequest*)request {
    [self.webView loadRequest:request];
}
-(id)init
{
    self = [super init] ;
    if (self) {
        [self commonInit] ;
    }
    return self ;
}

-(void)commonInit
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    WKUserContentController *controller = [[WKUserContentController alloc]init];
    // Add a script handler for the "observe" call. This is added to every frame
    // in the document (window.webkit.messageHandlers.NAME).
    [controller addScriptMessageHandler:self name:@"observe"];
    configuration.userContentController = controller ;
    configuration.processPool = [WKProcessPoolManager sharedManager] ;
    self.webView = [[YCWebView alloc]initWithFrame:CGRectZero configuration:configuration];
    self.webView.backgroundColor = [UIColor whiteColor] ;
    self.webView.allowsBackForwardNavigationGestures = YES ;
    self.webView.UIDelegate = self ;
    self.webView.navDelegate = self ;
    self.webView.scrollView.delegate = self ;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0,0);
    self.webView.scrollView.contentInset = insets;
    self.headerBar.hidden = YES ;
    self.showBackButton = NO ;
    _isRoot = YES ;
    _indexdArray = [NSMutableArray array] ;
    
}

-(void)setShowBackButton:(BOOL)showBackButton
{
    _showBackButton = showBackButton ;
    if (self.showBackButton) {
        self.headerBar.hidden = NO ;
    }else
    {
        self.headerBar.hidden = YES ;
    }
}

#pragma mark - view lifecycle

#pragma mark - Controller lifecycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self loadRequest:_request];
    [self.view insertSubview:self.webView atIndex:0];
    if (self.showBackButton) {
        self.headerBar.hidden = NO ;
    }else
    {
        self.headerBar.hidden = YES ;
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated] ;
    if (!_leftSwipGesture) {
        _leftSwipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipeAction:)];
        _leftSwipGesture.direction = (UISwipeGestureRecognizerDirectionLeft );
        [self.view addGestureRecognizer:_leftSwipGesture];
    }
    if (!_rightSwipGesture) {
        _rightSwipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeAction:)];
        _rightSwipGesture.direction = (UISwipeGestureRecognizerDirectionRight );
        [self.view addGestureRecognizer:_rightSwipGesture];
    }
}

-(void)leftSwipeAction:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self.webView evaluateJavaScript:@"slideToLeft();" completionHandler:nil];
}

-(void)rightSwipeAction:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self.webView evaluateJavaScript:@"slideToRight();" completionHandler:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    if (!_isRoot) {
        UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
        statusView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"] ;
        [self.view addSubview:statusView] ;
        [self.view addSubview:_progressView];
        self.webView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    }else
    {
        UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
        statusView.backgroundColor = [UIColor whiteColor] ;
        [self.view addSubview:statusView] ;
        [self.view addSubview:_progressView];
        self.webView.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64) ;
    }
}

-(void)showShareView:(id)sender
{
//    YCShareViewController *shareViewController = [[YCShareViewController alloc]init];
//    shareViewController.view.frame = self.view.frame ;
//    [[[UIApplication sharedApplication] keyWindow] addSubview:shareViewController.view];
//    [shareViewController showSharePanel] ;
    if (!_shareView) {
        _shareView = [[UIView alloc]initWithFrame:self.view.frame];

    }
    _shareView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideShare)];
    [_shareView addGestureRecognizer:tap];
    [self.view addSubview:_shareView];
    [self showShare] ;
}
-(void)hideShare
{
    [UIView animateWithDuration:0.3f animations:^{
        _sharePanel.frame  = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 300);
    } completion:^(BOOL finished) {
        [_shareView removeFromSuperview];
    }];
}
-(void)showShare;
{
    if (!_sharePanel) {
        _sharePanel  = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 150)];
        _qqButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_qqButton setImage:[UIImage imageNamed:@"qqShareIcon"] forState:UIControlStateNormal];
        _qqButton.frame = CGRectMake(75, 40, 45, 45);
        [_sharePanel addSubview:_qqButton];
        [_qqButton addTarget:self action:@selector(qqShare:) forControlEvents:UIControlEventTouchUpInside];
        
        _wxButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_wxButton setImage:[UIImage imageNamed:@"wxShareIcon"] forState:UIControlStateNormal];
        _wxButton.frame = CGRectMake(145, 40, 45, 45);
        [_sharePanel addSubview:_wxButton];
        [_wxButton addTarget:self action:@selector(wxShare:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _weiboButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_weiboButton setImage:[UIImage imageNamed:@"weiboLogo"] forState:UIControlStateNormal];
        _weiboButton.frame = CGRectMake(215, 40, 45, 45);
        [_sharePanel addSubview:_weiboButton];
        [_weiboButton addTarget:self action:@selector(weiboShare:) forControlEvents:UIControlEventTouchUpInside];
        _sharePanelBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_sharePanel.frame)-44, CGRectGetWidth(_sharePanel.frame), 44)];
        _sharePanelBackBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sharePanelBackBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sharePanelBackBtn setTitle:@"返回" forState:UIControlStateNormal];
        _sharePanelBackBtn.titleLabel.font = [UIFont systemFontOfSize:21];
        [_sharePanelBackBtn addTarget:self action:@selector(shareBack:) forControlEvents:UIControlEventTouchUpInside];
        [_sharePanel addSubview:_sharePanelBackBtn];
    }
    _sharePanel.backgroundColor = [UIColor whiteColor] ;
    [_shareView addSubview:_sharePanel];
    [UIView animateWithDuration:0.3f animations:^{
        _sharePanel.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 150 , CGRectGetWidth(self.view.frame), 150) ;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)shareBack:(id)sender
{
    [self hideShare] ;
}
-(void)qqShare:(id)sender
{
    NSString *htmlUrl = [YCShareManager sharedManager].shareRedirectURL ;
    QQBaseReq *req =  [QQShareManager QQNewsReq:htmlUrl htmlTitle:[YCShareManager sharedManager].shareTitle htmlDescription:[YCShareManager sharedManager].shareDescription previewImageUrl:[YCShareManager sharedManager].shareIconUrl] ;
    [YCShareManager sendReq:req];
}

-(void)weiboShare:(id)sender
{
        NSString *htmlUrl = [YCShareManager sharedManager].shareRedirectURL ;
    WBBaseRequest *req = [WeiboManager WeiboPageReq:htmlUrl title:[YCShareManager sharedManager].shareTitle description:[YCShareManager sharedManager].shareDescription];
    [[WeiboManager sharedManager] sendReq:req];
}

-(void)wxShare:(id)sender
{
    NSString *htmlUrl = [YCShareManager sharedManager].shareRedirectURL ;
    SendMessageToWXReq *req = [WXShareManager WXPageReq:htmlUrl title:[YCShareManager sharedManager].shareTitle  description:[YCShareManager sharedManager].shareDescription];
    [YCShareManager sendReq:req];
}

-(void)leftButtonClick
{
    [self goBackward:nil];
}

#pragma mark - View lifecycle


#pragma mark - Getters
-(UIProgressView *)progressView
{
    if (!_progressView) {
        CGFloat linHeight = 2.0f ;
        CGRect frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), linHeight);
        UIProgressView *progressView = [[UIProgressView alloc]initWithFrame:frame];
        progressView.trackTintColor = [UIColor clearColor];
        progressView.progressTintColor = [UIColor colorWithHexString:@"#FD5E0F"] ;
        progressView.alpha = 0.0f ;
        [self.view addSubview:progressView];
        _progressView = progressView ;
    }
    return _progressView ;
}

-(void)setRequest:(NSURLRequest *)request
{
    if ([request.URL isEqual:self.request.URL]) {
        return ;
    }
    if (self.isViewLoaded) {
        
        [self loadRequest:request] ;
    }
    _request = request ;
}

- (void)setLoadingError:(NSError *)error
{
    switch (error.code) {
        case NSURLErrorUnknown:
        case NSURLErrorCancelled:   return;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:error.localizedDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    [alert show];
}

- (void)goBackward:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView evaluateJavaScript:@"goBack();" completionHandler:nil];
    }else
    {
        if ([self.navigationController.viewControllers count]>1) {
             [self.navigationController popViewControllerAnimated:YES];
        }
       
    }
}

- (void)clearProgressViewAnimated:(BOOL)animated
{
    if (!_progressView) {
        return;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0
                     animations:^{
                         self.progressView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self destroyProgressViewIfNeeded];
                     }];
}

- (void)destroyProgressViewIfNeeded
{
    if (_progressView) {
        [_progressView removeFromSuperview];
        _progressView = nil;
    }
}

-(void)setIsRoot:(BOOL)isRoot
{
    _isRoot = isRoot ;
    if (!_isRoot) {
       // self.webView.frame = CGRectMake(0, 64, self.webView.frame.size.width, self.webView.frame.size.height);
    }
}

#pragma mark - 


- (void)webView:(YCWebView *)webView didUpdateProgress:(CGFloat)progress
{
    
    if (self.progressView.alpha == 0 && progress > 0) {
        
        self.progressView.progress = 0;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.progressView.alpha = 1.0;
        }];
    }
    else if (self.progressView.alpha == 1.0 && progress == 1.0)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.progressView.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.progressView.progress = 0;
        }];
    }
    NSLog(@"%f",progress) ;
    [self.progressView setProgress:progress animated:YES];
}

- (void)webView:(YCWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{

}

- (void)webView:(YCWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self setLoadingError:error];
    
    // if this is a cancelled error, then don't affect the title
    switch (error.code) {
        case NSURLErrorCancelled:   return;
    }
}

#pragma mark - WKUIDelegate
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog(@"isMainFrame======%d",navigationAction.targetFrame.isMainFrame);
    if (navigationAction.targetFrame.isMainFrame) {

        return self.webView ;
    }else
    {
        YCWebViewController *web = [[YCWebViewController alloc]initWithURLRequest:navigationAction.request];
        web.headerBar.hidden = NO ;
        [self.navigationController pushViewController:web animated:YES];
        return nil;
    }
    
}

-(void)customHtmlAction:(id)sender
{
    YCHTMLButton *button = (YCHTMLButton *)sender ;
    NSString *jsoncode = [NSString stringWithFormat:@"%@('%@');",button.jsFunction,button.buttonId] ;
    [self.webView evaluateJavaScript:jsoncode completionHandler:^(id result, NSError *error) {
        
    }];
}

#pragma mark - WebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL.absoluteString);

    return YES ;
}

#pragma mark - WKNavigationDelegate

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{

    NSURL *url = navigationAction.request.URL ;
    if ([url.scheme isEqualToString:@"tel"]) {
        [[UIApplication sharedApplication] openURL:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }else
    {
        if (navigationAction.targetFrame.isMainFrame == 1) {
            //current Page
            [self.headerBar clearRightBtns];
        }
    }

    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

-(void)webView:(YCWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{

    NSLog(@"start load") ;
}

-(void)webView:(YCWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    //不等于开始时的url
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:[self.webView isLoading]];
        [self.webView evaluateJavaScript:@"var u = navigator.userAgent; window.webkit.messageHandlers.observe.postMessage(u)" completionHandler:nil];
}

#pragma mark - WKScriptMessageHander
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    // Check to make sure the name is correct
    if ([message.name isEqualToString:@"observe"]) {
        // Log out the message received
        NSLog(@"Received event %@", message.body);
//        NSString *jsonStr = message.body ;
//        NSData *objectData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
//                                                             options:NSJSONReadingMutableContainers
//                                                               error:&jsonError];
        NSDictionary *json = message.body ;
        if (json && [json isKindOfClass:[NSDictionary class]]) {
            NSString *functionName = [json objectForKey:@"functionName"];
            if ([functionName isEqualToString:@"closeWebView"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([functionName isEqualToString:@"createButtonOnTopRight"])
            {
               // if (_createRButton) {
                    NSString *buttonId = [[json objectForKey:@"parameters"] objectForKey:@"buttonId"];
                    NSString *text = [[json objectForKey:@"parameters"] objectForKey:@"text"];
                    NSString *iconUrl = [[json objectForKey:@"parameters"] objectForKey:@"iconUrl"] ;
                    NSString *jsUrl = [[json objectForKey:@"parameters"] objectForKey:@"jsFunction"] ;
                    _createRButton = [[YCHTMLButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)] ;
                    [_createRButton setTitle:text forState:UIControlStateNormal];
                    _createRButton.buttonId = buttonId ;
                    _createRButton.iconUrl = iconUrl ;
                    _createRButton.jsFunction = jsUrl ;
                    [self.headerBar addToRightButtons:_createRButton];
                    [_createRButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:iconUrl]];
                    [_createRButton setTitleColor:[UIColor colorWithHexString:@"#FD5E0F"] forState:UIControlStateNormal];
                    [_createRButton addTarget:self action:@selector(customHtmlAction:) forControlEvents:UIControlEventTouchUpInside];
                    //[_indexdArray addObject:_createRButton];
                    //[self layoutHeaderRight] ;
              //  }
                
            }else if ([functionName isEqualToString:@"createShareButton"])
            {
                if (!_shareBtn) {
                    NSDictionary *parameters = [json objectForKey:@"parameters"];
                    if (parameters) {
                        NSString *shareDescription = [parameters objectForKey:@"description"] ;
                        NSString *shareIconUrl = [parameters objectForKey:@"iconUrl"] ;
                        NSString *shareTitle = [parameters objectForKey:@"title"] ;
                        NSString *url = [parameters objectForKey:@"url"] ;
                        [YCShareManager sharedManager].shareDescription = shareDescription ;
                        [YCShareManager sharedManager].shareIconUrl = shareIconUrl ;
                        [YCShareManager sharedManager].shareTitle = shareTitle ;
                        [YCShareManager sharedManager].shareRedirectURL = url ;
                    }
                    _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)] ;

                    [_shareBtn setImage:[UIImage imageNamed:@"shareIcon"] forState:UIControlStateNormal];
                    [_shareBtn addTarget:self action:@selector(showShareView:) forControlEvents:UIControlEventTouchUpInside];
                                        [self.headerBar addToRightButtons:_shareBtn];
                    //_shareBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 45, 0, 45, 45) ;
                    //[_indexdArray addObject:_shareBtn];
                    //[self layoutHeaderRight] ;
                }
                
            }else if ([functionName isEqualToString:@"createCallButton"])
            {
                NSString *phoneNumberText = [[json objectForKey:@"parameters"] objectForKey:@"phone"];
                if (phoneNumberText) {
                    [[[UIAlertView alloc] initWithTitle:@"Call phone"
                                                message:[NSString stringWithFormat:@"Call%@",phoneNumberText]
                                       cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
                        NSString *phoneNumber = [@"tel://" stringByAppendingString:phoneNumberText] ;
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]] ;
                    }]
                                       otherButtonItems:[RIButtonItem itemWithLabel:@"NO" action:^{
                        // Handle "Delete"
                    }], nil] show];

                }

            }else if ([functionName isEqualToString:@"openInSystemBrowser"])
            {
                NSString *urlString = [[json objectForKey:@"parameters"]objectForKey:@"url"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }else if ([functionName isEqualToString:@"setTitle"])
            {
                NSString *title = [[json objectForKey:@"parameters"] objectForKey:@"text"] ;
                [self.headerBar setTitle:title];
                NSString *jsFunction = [[json objectForKey:@"parameters"] objectForKey:@"jsFunction"];
                if (jsFunction) {
                    jsFunction = [NSString stringWithFormat:@"%@();",jsFunction] ;
                    [self.webView evaluateJavaScript:jsFunction completionHandler:nil] ;
                }

            }else if ([functionName isEqualToString:@"loginByWechat"])
            {
                NSString *cancelFunction = [[json objectForKey:@"parameters"] objectForKey:@"cancelFunction"];
                NSString *successFunction = [[json objectForKey:@"parameters"] objectForKey:@"successFunction"];
                [WXShareManager sharedManager].delegate = self ;
                [WXShareManager sharedManager].cancelFunction = cancelFunction ;
                [WXShareManager sharedManager].successFunction = successFunction ;
                [[WXShareManager sharedManager] login];
            }else if ([functionName isEqualToString:@"loginByQQ"])
            {
                NSString *cancelFunction = [[json objectForKey:@"parameters"] objectForKey:@"cancelFunction"];
                NSString *successFunction = [[json objectForKey:@"parameters"] objectForKey:@"successFunction"];
                [QQShareManager sharedManager].delegate = self ;
                [QQShareManager sharedManager].cancelFunction = cancelFunction ;
                [QQShareManager sharedManager].successFunction = successFunction ;
                [[QQShareManager sharedManager] login];
            }else if ([functionName isEqualToString:@"loginByWeibo"])
            {
                NSString *cancelFunction = [[json objectForKey:@"parameters"] objectForKey:@"cancelFunction"];
                
                NSString *successFunction = [[json objectForKey:@"parameters"] objectForKey:@"successFunction"];
                
                [WeiboManager sharedManager].delegate = self ;
                [WeiboManager sharedManager].cancelFunction = cancelFunction ;
                [WeiboManager sharedManager].successFunction = successFunction ;
                [[WeiboManager sharedManager] login];
            }
        }
    }
}


-(void)otherDidLogin:(NSString *)jsCode
{
    [self.webView evaluateJavaScript:jsCode completionHandler:nil];
}

-(void)otherDidLoginFaild:(NSString *)jsCode 
{
    [self.webView evaluateJavaScript:jsCode completionHandler:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //pull
    NSLog(@"%f",scrollView.contentOffset.y);
    if ( scrollView.contentOffset.y < -65) {
        [self.webView evaluateJavaScript:@"pullDown();" completionHandler:nil] ;
    }else if (scrollView.contentOffset.y > 80 )
    {
        // load more
        [self.webView evaluateJavaScript:@"pushUp();" completionHandler:nil];
    }
}

@end
