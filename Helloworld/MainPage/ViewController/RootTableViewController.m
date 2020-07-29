//
//  RootTableViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/3.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "RootTableViewController.h"
#import "NewsListTableViewController.h"
#import "YUNPlayOnlineAudioViewController.h"
#import "GetAlbumPictureViewController.h"
#import "YunPopViewController.h"
#import "WKWebViewViewController.h"
#import "AFNetworkingViewController.h"
#import "DownLoadImageViewController.h"
#import "MultiThreadViewController.h"
#import "AppOpenURLViewController.h"
#import "NotificationViewController.h"
#import "LottieViewController.h"
#import "YunSDWebImageViewController.h"
#import "YunDrawRectViewController.h"
//#import <AspectsV1.4.2/Aspects.h>
#import "YunMethodSwizzlingViewController.h"
#import "TestBridgeViewController.h"
#import "YunTestViewController.h"
#import "YUNWechatLoginViewController.h"
#import "YUNHashViewController.h"
#import "ThreadSafetyViewController.h"
#import "BackgroundTaskViewController.h"
#import "StrongWeakBlcokViewController.h"
#import "YUNRunloopViewController.h"
#import "FLAnimatedViewController.h"
#import "ContentOfLayerViewController.h"
#import "YUNGestureViewController.h"
#import "YUNAudioViewController.h"
#import "YUNKnowledgeItem.h"
#import "GetMainColorFromImageViewController.h"
#import "YUNUIInterfaceOrientationViewController.h"
#import "QNObjcViewController.h"
#import "QNTestCategoryChildController.h"
#import "QNTestCategoryController.h"
#import <AdSupport/AdSupport.h>
#import "BlurEffectViewController.h"
#import "YUNJSPatchViewController.h"

@interface RootTableViewController ()

@property(nonatomic, strong) NSMutableArray<YUNKnowledgeItem *> *array;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSLog(@"idfa = %@", idfa);
    }
    
    NSLog(@"1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    }) ;
    NSLog(@"3");
    
    // 去除多余cell分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.array = [NSMutableArray array];
    
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"AVAudioPlayer 播放本地音频" viewCtlName:@"YUNAudioViewController"]];
////    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"播放在线音频" viewCtlName:@"YUNAudioOnlineViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"AVFundation 播放在线music" viewCtlName:@"YUNPlayOnlineAudioViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"AVFundation 播放在线video" viewCtlName:@"VideoViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"获取相册中的图片" viewCtlName:@"GetAlbumPictureViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"获取图片的主颜色" viewCtlName:@"GetMainColorFromImageViewController"]];

//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"SwiftObjectiveC桥接规范" viewCtlName:@"QNObjcViewController"]];
      [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"JSPatch 原理" viewCtlName:@"YUNJSPatchViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"模糊效果" viewCtlName:@"BlurEffectViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"QNTestCategoryChildController" viewCtlName:@"QNTestCategoryChildController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"QNTestCategoryController" viewCtlName:@"QNTestCategoryController"]];

//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"SwiftObjectiveC桥接" viewCtlName:@"QNObjcViewController"]];

//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"获取相册中的图片" viewCtlName:@"GetAlbumPictureViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"UIInterfaceOrientation" viewCtlName:@"YUNUIInterfaceOrientationViewController"]];
    
    /*
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"下拉刷新" viewCtlName:@"NewsListTableViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"学习AVFundation" viewCtlName:@"LearnAVFundationViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"获取相册中的图片" viewCtlName:@"GetAlbumPictureViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"弹出自定义窗口" viewCtlName:@"YunPopViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"WKWebView" viewCtlName:@"WKWebViewViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"AFNetworking" viewCtlName:@"AFNetworkingViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"NSURLSession下载图片" viewCtlName:@"DownLoadImageViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"多线程" viewCtlName:@"MultiThreadViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"线程安全" viewCtlName:@"ThreadSafetyViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"应用间跳转" viewCtlName:@"AppOpenURLViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"push通知" viewCtlName:@"NotificationViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"lottie动画" viewCtlName:@"LottieViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"SDWebImage" viewCtlName:@"YunSDWebImageViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"DrawRect" viewCtlName:@"YunDrawRectViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"Method Swizzling" viewCtlName:@"YunMethodSwizzlingViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"JSBridge" viewCtlName:@"TestBridgeViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"零碎test代码合集" viewCtlName:@"YunTestViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"微信SDK" viewCtlName:@"YUNWechatLoginViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"关于hash函数" viewCtlName:@"YUNHashViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"BackgroundTaskViewController" viewCtlName:@"BackgroundTaskViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"StrongWeakBlcokViewController" viewCtlName:@"StrongWeakBlcokViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"YUNRunloopViewController" viewCtlName:@"YUNRunloopViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"FLAnimatedViewController" viewCtlName:@"FLAnimatedViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"ContentOfLayerViewController" viewCtlName:@"ContentOfLayerViewController"]];
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"YUNGestureViewController" viewCtlName:@"YUNGestureViewController"]];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row].title;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *nextPage = nil;
    if (indexPath.row >= [self.array count]) {
        return;
    }
    
    YUNKnowledgeItem *item = [self.array objectAtIndex:indexPath.row];
    Class clazz = NSClassFromString(item.viewCtlName);
    nextPage = [[clazz alloc] init];
    
    if (nextPage != nil) {
        [self.navigationController pushViewController:nextPage animated:YES];
    }
}

@end
