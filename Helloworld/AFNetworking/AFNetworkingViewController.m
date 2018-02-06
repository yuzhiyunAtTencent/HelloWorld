//
//  AFNetworkingViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/6.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface AFNetworkingViewController ()

@property(nonatomic, strong) AFNetworkReachabilityManager *manager;
@property(nonatomic, strong) UILabel *netStatusLabel;

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.netStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kQNNavigationBarHeight_DP + kQNSystemStatusBarHeight, SCREEN_WIDTH, 20)];
    [self.view addSubview:self.netStatusLabel];
    
    [self judgeNet];
}

// 判断网络
- (void)judgeNet {
    self.manager = [AFNetworkReachabilityManager manager];
    [self.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"网络不可用");
                self.netStatusLabel.text = @"网络不可用";
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                NSLog(@"Wifi已开启");
                self.netStatusLabel.text = @"Wifi已开启";
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"你现在使用的流量");
                self.netStatusLabel.text = @"你现在使用的流量";
                break;
            }
                
            case AFNetworkReachabilityStatusUnknown: {
                NSLog(@"你现在使用的未知网络");
                self.netStatusLabel.text = @"你现在使用的未知网络";
                break;
            }
                
            default:
                break;
        }
    }];
    [self.manager startMonitoring];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
