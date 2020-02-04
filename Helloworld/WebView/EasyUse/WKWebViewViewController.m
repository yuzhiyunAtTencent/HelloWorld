//
//  WKWebViewViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/5.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "WKWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewViewController () <WKUIDelegate, WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *webView;
@end

@implementation WKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration =[[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kQNNavigationBarHeight_DP + kQNSystemStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:configuration];
    [self.view addSubview:self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://view.inews.qq.com/a/20190726A0S73500?uid=100146243534&shareto=wx"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];
    
    [self setMenu];
}

- (void)setMenu {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    [menuController setMenuItems:[self contextMenuItems]];
}

- (NSArray*)contextMenuItems {
    static NSArray* menuItems;
    if (!CHECK_VALID_ARRAY(menuItems)) {
        NSArray* data = @[
                          @[@"分享", @"share"],                 //分享
                          ];
        NSMutableArray* items = [NSMutableArray array];
        
        for (NSArray* pair in data) {
            NSString* title = pair[0];
            NSString* selector = pair[1];
            UIMenuItem* menuItem = [[UIMenuItem alloc] initWithTitle:title action:NSSelectorFromString(selector)];
            [items addObject:menuItem];
        }
        menuItems = items;
    }
    return menuItems;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    //拦截百度页面
    if ([url.absoluteString containsString:@"baidu"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)testUnusedMethod {
    NSLog(@"测试删除无用方法的工具是否有用");
}

@end
