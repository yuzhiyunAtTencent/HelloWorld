//
//  AppOpenURLViewController.m
//  Helloworld
//
//  Created by 俞志云 on 2018/7/6.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "AppOpenURLViewController.h"

@interface AppOpenURLViewController ()

@end

@implementation AppOpenURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"跳转到ARAlbum" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(jumpToARAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 1、的确可以跳过去，前提是两个应用都在info.plist设置好了URL Type和 LSApplicationQueriesSchemes
 * 2、在目的app的appDelegate中的这个函数会被回调：-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url
 */
- (void)jumpToARAlbum {
    NSURL *url = [NSURL URLWithString:@"ARAlbum://openMyPage"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
