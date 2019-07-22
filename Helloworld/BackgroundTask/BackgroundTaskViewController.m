//
//  BackgroundTaskViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/7/15.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "BackgroundTaskViewController.h"

@interface BackgroundTaskViewController ()

@end

@implementation BackgroundTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     UIBackgroundTaskIdentifier *taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
    }];
    int num = 0;
    while (1) {
        num++;
        [NSThread sleepForTimeInterval:1];
        NSLog(@"zhiyun print task num = %i", num);
        
        NSTimeInterval remaingTime = [[UIApplication sharedApplication] backgroundTimeRemaining];
        NSLog(@"后台任务时间剩余：%f",remaingTime);
    }
    
    [[UIApplication sharedApplication] endBackgroundTask:taskIdentifier];
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
