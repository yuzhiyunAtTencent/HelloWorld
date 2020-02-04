//
//  YUNGestureViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/10/23.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "YUNGestureViewController.h"

@interface YUNGestureViewController ()

@end

@implementation YUNGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 300, 400)];
    aView.backgroundColor = [UIColor blueColor];
    
    [aView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_a)]];
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    bView.backgroundColor = [UIColor redColor];
    
    [bView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_b)]];
    [bView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_longPress)]];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_btnLongPress)]];
    [btn addTarget:self action:@selector(_btn_click) forControlEvents:UIControlEventTouchUpInside];
    
    [aView addSubview:bView];
    [bView addSubview:btn];
    
    [self.view addSubview:aView];
}

- (void)_a {
    NSLog(@"superView clicked");
}

- (void)_b {
    NSLog(@"subView clicked");
}

- (void)_longPress {
    NSLog(@"subView _longPress");
}

- (void)_btnLongPress {
    NSLog(@"_btnLongPress");
}

- (void)_btn_click {
    NSLog(@"_btn_click");
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
