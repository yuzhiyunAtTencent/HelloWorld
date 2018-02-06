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

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self judgeNet];
}

// 判断网络
- (void)judgeNet {
    self.manager = [AFNetworkReachabilityManager manager];
    [self.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"网络不可用");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                NSLog(@"Wifi已开启");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"你现在使用的流量");
                break;
            }
                
            case AFNetworkReachabilityStatusUnknown: {
                NSLog(@"你现在使用的未知网络");
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
