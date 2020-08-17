//
//  YunPrivacySafetyViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/8/17.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "YunPrivacySafetyViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

@interface YunPrivacySafetyViewController ()

@end

@implementation YunPrivacySafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testIDFA];
}

- (void)testIDFA {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString *idfaString = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
                NSLog(@"iOS 14 idfa = %@", idfaString);
            } else {
                NSLog(@"iOS 14 获取idfa授权不通过");
            }
        }];
    } else {
        // 使用原方式访问 IDFA
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString *idfaString = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
            NSLog(@"idfa = %@", idfaString);
        } else {
            NSLog(@"用户主动设置了：限制广告跟踪（路径：设置〉隐私〉广告）");
        }
    }
}

@end
