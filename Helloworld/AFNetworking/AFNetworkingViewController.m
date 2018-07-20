//
//  AFNetworkingViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/6.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFURLResponseSerialization.h>
#import <AFNetworking/AFURLRequestSerialization.h>

@interface AFNetworkingViewController ()

@property(nonatomic, strong) AFNetworkReachabilityManager *manager;

@property(nonatomic, strong) UILabel *netStatusLabel;
@property(nonatomic, strong) UIImageView *iconImageView;

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.netStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kQNNavigationBarHeight_DP + kQNSystemStatusBarHeight, SCREEN_WIDTH, 20)];
    [self.view addSubview:self.netStatusLabel];
    [self judgeNet];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(callJSONNetAPI) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"访问JSON接口" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(callDownloadFileAPI) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"下载文件" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 100, 40)];
    [self.view addSubview:self.iconImageView];
}

- (void)callDownloadFileAPI {
    
    
    
    // 1.网络请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 让AFN返回原始的二进制数据,我们自己来解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://old.bz55.com/uploads/allimg/160125/139-160125150940.jpg"]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 在这个代码块里面指定文件下载完成之后的缓存路径,指定好了之后,会自动的剪切到completionHandler里面
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"newIconImage.jpg"];
        NSURL *pathURL = [NSURL fileURLWithPath:fullPath];
        return pathURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完后,从Documents里获取头像,并显示
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *newIconImagePath = [documents stringByAppendingPathComponent:@"newIconImage.jpg"];
        UIImage *newIconImage = [UIImage imageWithContentsOfFile:newIconImagePath];
        if (newIconImage == nil) {
            self.iconImageView.image = [UIImage imageNamed:@"myCenter_placeholder"];
        } else {
            self.iconImageView.image = newIconImage;
        }
        
    }];
    [downloadTask resume];
    
}

// 访问JSON接口
- (void)callJSONNetAPI {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSString *urlString = @"http://v.juhe.cn/historyWeather/province?key=9292ea9a4f8a17acd083a98e79e4bbe5";
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        UIAlertController *alertController;
        
        if (error) {
            NSLog(@"Error: %@", error);
            alertController = [UIAlertController alertControllerWithTitle:@"访问失败" message:[NSString stringWithFormat:@"%@", error] preferredStyle:UIAlertControllerStyleAlert];
        } else {
            NSLog(@"%@", response);
            NSDictionary *responseDic = (NSDictionary*)responseObject;
            
            alertController = [UIAlertController alertControllerWithTitle:@"访问成功" message:[NSString stringWithFormat:@"%@", responseDic] preferredStyle:UIAlertControllerStyleAlert];
        }
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    [dataTask resume];
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
