//
//  NotificationViewController.m
//  Helloworld
//
//  Created by 俞志云 on 2018/7/8.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // test
    // test git twice
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"发送本地通知" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(sendLocalNotification) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

// 发送本地通知 （不需要设置push证书就可以收到通知）
- (void)sendLocalNotification {
    // 通知内容
    UNMutableNotificationContent *content_1 = [[UNMutableNotificationContent alloc] init];
    // 主标题
    content_1.title = [NSString localizedUserNotificationStringForKey:@"title" arguments:nil];
    // 副标题
    content_1.subtitle = [NSString localizedUserNotificationStringForKey:@"subtitle" arguments:nil];
    content_1.badge = [NSNumber numberWithInteger:1];
    content_1.body = [NSString localizedUserNotificationStringForKey:@"title_message_for_you" arguments:nil];
    content_1.sound = [UNNotificationSound defaultSound];
    // 指定了categoryIdentifier之后就可以和申请push权限时候的categoryIdentifier 一一对应起来啦。 然后对应的action也会生效啦。
    content_1.categoryIdentifier = @"view_news_detail";
    // 设置触发时间
    UNTimeIntervalNotificationTrigger *trigger_1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    // 创建一个发送请求
    UNNotificationRequest *request_1 = [UNNotificationRequest requestWithIdentifier:@"request" content:content_1 trigger:trigger_1];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request_1 withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"发送通知出错： %@", error);
        } else {
            NSLog(@"发送通知成功");
        }
    }];
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
