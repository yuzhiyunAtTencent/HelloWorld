//
//  AppDelegate.m
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/6.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import "AppDelegate.h"
//#import "MainViewController.h"
#import "NewsListTableViewController.h"
#import "RootTableViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <AspectsV1.4.2/Aspects.h>

QN_DECLARE_CONST_NSSTRING(kQNViewAction);
QN_DECLARE_CONST_NSSTRING(kQNFavoriteAction);
QN_DECLARE_CONST_NSSTRING(kQNUninterestAction);
QN_DECLARE_CONST_NSSTRING(kQNCancelAction);
QN_DECLARE_CONST_NSSTRING(kQNReturnToListViewEvent);
QN_DECLARE_CONST_NSSTRING(kQNUserHasReadArticleEvent);
QN_DECLARE_CONST_NSSTRING(kQNReadArticleTimesKey);

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 在 master 修改代码
    // 在 master 再次修改代码
    // 在 master 第三次修改代码
    // 在 master 第四次修改代码
    // 使用Aspect hook了UIViewController的viewDidAppear函数
    /*[UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"%@: %@", [aspectInfo.instance class], aspectInfo.arguments);
        NSLog(@"viewDidAppear -->>>>>>>>>><<<<<<<<<<<<<--");
    } error:nil];
     */
    // 在test分支修改
    // 在test分支再次修改
    // 在test2分支修改
    // 10.0 之后的通知
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [self p_requestPushAuthorize];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//设置窗口
    UIViewController *mainVC = [[RootTableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;//进入的首个页面
    [self.window makeKeyAndVisible];//显示
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:32];
    [string appendFormat:@"%02hhx",223333];
    NSLog(string);
    
    
    
    
    
    return YES;
}

// 其他app通过openURL跳转到这个 app 会回调这个函数
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"传过来的url是" message:url.absoluteString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
    
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UNUserNotificationCenterDelegate
/** 当收到通知时候 用户处于前台时,不在通知栏展示通知UI，可以在这里处理逻辑*/
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    NSLog(@"前台 不展示通知");
}

/** 当收到通知时候 不处于前台时,与通知交互走这个方法 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    NSLog(@"点击通知");
}

#pragma mark - Private
// 申请push权限
- (void)p_requestPushAuthorize {
    if ([UNNotificationCategory
         respondsToSelector:@selector(categoryWithIdentifier:actions:intentIdentifiers:options:)]) {
        UNNotificationAction *checkAction =
        [UNNotificationAction actionWithIdentifier:kQNViewAction
                                             title:@"打开"
                                           options:UNNotificationActionOptionForeground];
        UNNotificationAction *storeUpAction =
        [UNNotificationAction actionWithIdentifier:kQNFavoriteAction
                                             title:@"收藏"
                                           options:UNNotificationActionOptionNone];
        UNNotificationAction *uninterestAction =
        [UNNotificationAction actionWithIdentifier:kQNUninterestAction
                                             title:@"不感兴趣"
                                           options:UNNotificationActionOptionNone];
        UNNotificationAction *cancelAction =
        [UNNotificationAction actionWithIdentifier:kQNCancelAction
                                             title:@"取消"
                                           options:UNNotificationActionOptionDestructive];
        
        NSArray *actionArray = [NSArray arrayWithObjects:checkAction, storeUpAction, uninterestAction, cancelAction, nil];
        // 这里设置了categoryIdentifier ，和本地通知的UNMutableNotificationContent的categoryIdentifier字段一一对应的，如果是远程通知，在推送的payload（就是一段json） 中添加 category 字段即可，这样对应起来后，action才会发挥作用
        UNNotificationCategory *category = [UNNotificationCategory
                                            categoryWithIdentifier:@"view_news_detail"
                                            actions:actionArray
                                            intentIdentifiers:@[]
                                            options:UNNotificationCategoryOptionCustomDismissAction];
        
        [[UNUserNotificationCenter currentNotificationCenter]
         setNotificationCategories:[NSSet setWithObject:category]];
    }
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound |
     UNAuthorizationOptionAlert
     completionHandler:^(BOOL granted, NSError *_Nullable error) {
         NSLog(@"用户允许push？ --- %@",granted?@"YES":@"NO");
         dispatch_async(
                        dispatch_get_main_queue(),
                        ^{
                            [[UIApplication sharedApplication] registerForRemoteNotifications];
                        });
     }];
}

@end
