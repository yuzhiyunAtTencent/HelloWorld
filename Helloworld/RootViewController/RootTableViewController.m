//
//  RootTableViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/3.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "RootTableViewController.h"
#import "NewsListTableViewController.h"
#import "LearnAVFundationViewController.h"
#import "GetAlbumPictureViewController.h"
#import "YunPopViewController.h"
#import "WKWebViewViewController.h"
#import "AFNetworkingViewController.h"
#import "DownLoadImageViewController.h"
#import "MultiThreadViewController.h"
#import "AppOpenURLViewController.h"
#import "NotificationViewController.h"

@interface RootTableViewController ()

@property(nonatomic, strong) NSMutableArray *array;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 去除多余cell分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.array = [NSMutableArray array];
    [self.array addObjectsFromArray:@[@"进入列表页", @"学习AVFundation", @"获取相册中的图片", @"弹出自定义窗口", @"WKWebView", @"AFNetworking", @"NSURLSession下载图片",@"多线程",@"应用间跳转",@"push通知"]];
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
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *nextPage = nil;
    switch (indexPath.row) {
        case 0:
            nextPage = [[NewsListTableViewController alloc] init];
            break;
        case 1:
            nextPage= [[LearnAVFundationViewController alloc] init];
            break;
        case 2:
            nextPage = [[GetAlbumPictureViewController alloc] init];
            break;
        case 3:
            nextPage = [[YunPopViewController alloc] init];
            break;
        case 4:
            nextPage = [[WKWebViewViewController alloc] init];
            break;
        case 5:
            nextPage = [[AFNetworkingViewController alloc] init];
            break;
        case 6:
            nextPage = [[DownLoadImageViewController alloc] init];
            break;
        case 7:
            nextPage = [[MultiThreadViewController alloc] init];
            break;
        case 8:
            nextPage = [[AppOpenURLViewController alloc] init];
            break;
        case 9:
            nextPage = [[NotificationViewController alloc] init];
            break;
        default:
            break;
    }
    if (nextPage != nil) {
        [self.navigationController pushViewController:nextPage animated:YES];
    }
}

@end
