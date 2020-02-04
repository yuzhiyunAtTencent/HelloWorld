//
//  YUNWechatLoginViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/1/11.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "YUNWechatLoginViewController.h"
#import "YUNTestPresentViewController.h"

@interface YUNWechatLoginViewController ()

@end

@implementation YUNWechatLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(wechatLogin) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"微信登陆" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)wechatLogin {
    NSLog(@"登陆");
    
    YUNTestPresentViewController *controller = [[YUNTestPresentViewController alloc] init];
//    controller.definesPresentationContext = YES;
    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:controller animated:YES completion:nil];
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
