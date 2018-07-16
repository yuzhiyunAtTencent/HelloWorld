//
//  LottieViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/7/16.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "LottieViewController.h"
#import <Lottie/Lottie.h>

@interface LottieViewController ()

@end

@implementation LottieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LOTAnimationView *lottieTest = [LOTAnimationView animationNamed:@"heart"];
    lottieTest.contentMode = UIViewContentModeScaleAspectFit;
    lottieTest.frame = self.view.bounds;
    lottieTest.loopAnimation = YES;
//    lottieTest.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.view addSubview:lottieTest];
    [lottieTest play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
