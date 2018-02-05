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

@interface RootTableViewController ()

@property(nonatomic, strong) NSMutableArray *array;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray array];
    [self.array addObjectsFromArray:@[@"进入列表页", @"学习AVFundation", @"获取相册中的图片", @"弹出自定义窗口"]];
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
            nextPage = [[NewsListTableViewController alloc]init];
            break;
        case 1:
            nextPage= [[LearnAVFundationViewController alloc]init];
            break;
        case 2:
            nextPage = [[GetAlbumPictureViewController alloc]init];
            break;
        case 3:
            nextPage = [[YunPopViewController alloc]init];
            break;
        default:
            break;
    }
    if (nextPage != nil) {
        [self.navigationController pushViewController:nextPage animated:YES];
    }
}

@end
