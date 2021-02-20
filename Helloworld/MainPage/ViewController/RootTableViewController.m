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
#import "YunPrivacySafetyViewController.h"
#import "TestPHPickerViewController.h"
#import "YUNAddStackFrameViewController.h"
#include <dlfcn.h>


@interface RootTableViewController ()

@property(nonatomic, strong) NSMutableArray<YUNKnowledgeItem *> *array;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIPasteboard generalPasteboard].string = @"";
    NSArray<NSDictionary *> *items = [UIPasteboard generalPasteboard].items;
//    NSLog(@"toast %@", [UIPasteboard generalPasteboard].string);
    
    NSSet *patterns = [[NSSet alloc] initWithObjects:UIPasteboardDetectionPatternProbableWebURL, UIPasteboardDetectionPatternProbableWebSearch, nil];
    [[UIPasteboard generalPasteboard] detectPatternsForPatterns:patterns
                                              completionHandler:^(NSSet<UIPasteboardDetectionPattern> * _Nullable result, NSError * _Nullable error) {
        if (result && result.count) {
            NSLog(@"");
        } else {
            NSLog(@"");
        }
    }];
    
//    NSDictionary *item = items.count > 0 ? items[0] : nil;
//    NSLog(@"toast %@", [UIPasteboard generalPasteboard].string);
//    NSLog(@"toast %@", [UIPasteboard generalPasteboard].items);
    
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
    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"在函数调用前增加一个栈帧，处理iOS Kotlin crash堆栈丢失问题"
                                                      viewCtlName:NSStringFromClass([YUNAddStackFrameViewController class])]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"获取相册中的图片" viewCtlName:NSStringFromClass([GetAlbumPictureViewController class])]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"获取图片的主颜色" viewCtlName:@"GetMainColorFromImageViewController"]];
//      [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"iOS14 用户隐私安全升级" viewCtlName:@"YunPrivacySafetyViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"SwiftObjectiveC桥接规范" viewCtlName:@"QNObjcViewController"]];
//      [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"JSPatch 原理" viewCtlName:@"YUNJSPatchViewController"]];
//      [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"iOS 14 图片权限问题" viewCtlName:NSStringFromClass([TestPHPickerViewController class])]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"NSURLSession下载图片" viewCtlName:NSStringFromClass([DownLoadImageViewController class])]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"模糊效果" viewCtlName:@"BlurEffectViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"QNTestCategoryChildController" viewCtlName:@"QNTestCategoryChildController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"QNTestCategoryController" viewCtlName:@"QNTestCategoryController"]];

//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"SwiftObjectiveC桥接" viewCtlName:@"QNObjcViewController"]];

//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"获取相册中的图片" viewCtlName:@"GetAlbumPictureViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"UIInterfaceOrientation" viewCtlName:@"YUNUIInterfaceOrientationViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"SDWebImage" viewCtlName:@"YunSDWebImageViewController"]];
//    [self.array addObject:[[YUNKnowledgeItem alloc] initWithTitle:@"NSNotificationCenter通知是同步的" viewCtlName:@"TestNotificationCenterViewController"]];
    
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
    
    [self hello];
}

- (void)hello {
    NSLog(@"开始打印：[NSThread callStackSymbols]");
    NSLog(@"%@", [NSThread callStackSymbols]);

    NSLog(@"===== 分隔符 =====");
    fastUnwind_frame();
}

static long idx = 0;
// 为了直观对比效果，本函数会将 函数名 和 指令的字节偏移量 进行打印
void dumpAddress(const void *p) {
    char *(*demangle)(char const *) = dlsym(RTLD_DEFAULT, "demangle");
    Dl_info info;
    if (dladdr(p, &info)) {
        char *demangleName = demangle(info.dli_sname);
        if (demangleName && strlen(demangleName) > 0) {
            NSLog(@"%ld 0x%016lx  %s + %@ \n", idx, (unsigned long)p, demangleName, @(p - info.dli_saddr));
//            printf("%ld 0x%016lx  %s + %ld \n", idx, (unsigned long)p, demangleName, p - info.dli_saddr);
        } else {
            NSLog(@"%ld 0x%016lx  %s + %@ \n", idx, (unsigned long)p, info.dli_sname , @(p - info.dli_saddr));
        }
    } else {
        printf("非法地址");
    }
    ++idx;
}

void fastUnwind_frame() {
    typedef uintptr_t frame_data_addr_t;
    
    struct frame_data {
        struct frame_data *frame_addr_next;
        frame_data_addr_t *ret_addr;
    };
    struct frame_data *fp = __builtin_frame_address(0);
    for (;;) {
        struct frame_data *next_fp = fp->frame_addr_next;
        if (next_fp <= fp) break;
        dumpAddress((fp->ret_addr));
        // printf("%p\n", *(fp+1));
        fp = next_fp;
    }
}

void fastUnwind() {
    /* __builtin_frame_address, the address of the function frame
     * 参数代表call stack的层级，0就是当前函数，1就是当前函数的caller，以此类推
     * https://www.daemon-systems.org/man/__builtin_frame_address.3.html
     * 注意还有一个__builtin_return_address 代表函数返回地址，和__builtin_frame_address是不一样的
     
     
     https://gcc.gnu.org/onlinedocs/gcc/Return-Address.html
     This function is similar to __builtin_return_address, but it returns the address of the function frame rather than the return address of the function. Calling __builtin_frame_address with a value of 0 yields the frame address of the current function, a value of 1 yields the frame address of the caller of the current function, and so forth.

     The frame is the area on the stack that holds local variables and saved registers. The frame address is normally the address of the first word pushed on to the stack by the function. However, the exact definition depends upon the processor and the calling convention. If the processor has a dedicated frame pointer register, and the function has a frame, then __builtin_frame_address returns the value of the frame pointer register.

     On some machines it may be impossible to determine the frame address of any function other than the current one; in such cases, or when the top of the stack has been reached, this function returns 0 if the first frame pointer is properly initialized by the startup code.

     Calling this function with a nonzero argument can have unpredictable effects, including crashing the calling program. As a result, calls that are considered unsafe are diagnosed when the -Wframe-address option is in effect. Such calls should only be made in debugging situations.
     */
    void **fp = __builtin_frame_address(0);
    
    for (;;) {
        void **next_fp = *fp;
        if (next_fp <= fp) break;
        dumpAddress(*(fp + 1));
        // printf("%p\n", *(fp+1));
        fp = next_fp;
    }
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
