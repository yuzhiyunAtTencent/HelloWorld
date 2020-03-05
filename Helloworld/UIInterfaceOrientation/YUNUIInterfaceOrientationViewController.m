//
//  YUNUIInterfaceOrientationViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/2/4.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "YUNUIInterfaceOrientationViewController.h"
#import "HorizontalViewController.h"
#import "AppDelegate.h"

@interface YUNUIInterfaceOrientationViewController ()

@end

@implementation YUNUIInterfaceOrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) {
        NSLog(@"UIInterfaceOrientationPortrait");
    }
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(jump)]];
    
    
    NSLog(@"[[UIApplication sharedApplication] statusBarOrientation] = %@", @([[UIApplication sharedApplication] statusBarOrientation]));

    NSLog(@"window.frame = %@", @([AppDelegate yun_window].frame));
}


//typedef NS_ENUM(NSInteger, UIInterfaceOrientation) {
//    UIInterfaceOrientationUnknown            = UIDeviceOrientationUnknown,
//    UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait,
//    UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
//    UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight,
//    UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft
//} API_UNAVAILABLE(tvos);

- (void)jump {
    [self.navigationController pushViewController:[[HorizontalViewController alloc] init]
    animated:YES];
}

@end
