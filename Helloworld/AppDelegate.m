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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//设置窗口
    UIViewController *mainVC = [[RootTableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;//进入的首个页面
    [self.window makeKeyAndVisible];//显示
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


@end
