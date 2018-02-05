//
//  YunPopViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/3.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "YunPopViewController.h"
#import "YunPopWindowView.h"

@interface YunPopViewController ()

@property(nonatomic, strong) YunPopWindowView *popView;

@end

@implementation YunPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    [btn setTitle:@"弹出自定义弹窗" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor blueColor];
    btn.backgroundColor = [UIColor brownColor];
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    btn.layer.borderWidth = 0.1f;
    [btn addTarget:self action:@selector(showPopView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    self.popView = [[YunPopWindowView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPopView {
    [self.popView showPopWindowView];
}

@end
