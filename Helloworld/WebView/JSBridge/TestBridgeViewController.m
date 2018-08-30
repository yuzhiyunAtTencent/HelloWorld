//
//  TestBridgeViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/8/30.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "TestBridgeViewController.h"
#import <WebKit/WebKit.h>

@interface TestBridgeViewController () <WKUIDelegate, WKNavigationDelegate>
@property(nonatomic, strong) WKWebView *webView;
@end

@implementation TestBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *configuration =[[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kQNNavigationBarHeight_DP + kQNSystemStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:configuration];
    self.webView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index"
                                                          ofType:@"html"];
    
    // 这是没用的 ,没有协议头 @"/Users/zhiyunyu/Library/Developer/CoreSimulator/Devices/EE71985E-5ACE-444A-A90F-FEDE64F242D3/data/Containers/Bundle/Application/011F773E-30CF-400B-8106-880E3F27407A/Helloworld.app/index.html"    0x000060400009c020
//    NSURL *urlWrong = [NSURL URLWithString:htmlPath];
    // 有协议头      @"file:///Users/zhiyunyu/Library/Developer/CoreSimulator/Devices/EE71985E-5ACE-444A-A90F-FEDE64F242D3/data/Containers/Bundle/Application/011F773E-30CF-400B-8106-880E3F27407A/Helloworld.app/index.html"    0x00006040000b8840
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark-WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"load finish");
}


- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSDictionary *dic = error.userInfo;
    NSLog(@"error");
    
}

#pragma mark-WKUIDelegate

/**
 *默认js不允许弹窗，所以需要自己提供原生窗口来支持弹窗
 */
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        NSLog(@"点击了取消按钮==%@",message);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        NSLog(@"点击了确定按钮==%@",message);
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
