//
//  YUNTestPresentViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/1/16.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "YUNTestPresentViewController.h"

@interface YUNTestPresentViewController ()

@end

@implementation YUNTestPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(wechatLogin) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"新页面" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
}

- (void)wechatLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
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
