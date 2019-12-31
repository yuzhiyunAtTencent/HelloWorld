//
//  NewsListTableViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/6.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import "NewsListTableViewController.h"
#import "NewsItemTableViewCell.h"
#import "News.h"

#import <SVPullToRefresh/SVPullToRefresh.h>

@interface NewsListTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray* newsArray;
@end


@implementation NewsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    News *news = [[News alloc] initWithPicUrl:@"oldUrl" title:@"oldTitle"];
    
    NSLog(@"%p", [news methodForSelector:@selector(setTitle:)]);
    
    [news addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    NSLog(@"%p", [news methodForSelector:@selector(setTitle:)]);
    
    [news willChangeValueForKey:@"title"];
    [news didChangeValueForKey:@"title"];
    
    self.newsArray=[[NSMutableArray  alloc]init];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"beauty.jpg" title:@"青青子衿 悠悠我心"]];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"helle.jpg" title:@"但为君故 沉吟至今"]];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"wawa.jpg"  title:@"呦呦鹿鸣 食野之萍"]];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"beauty.jpg" title:@"青青子衿 悠悠我心"]];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"helle.jpg" title:@"但为君故 沉吟至今"]];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"wawa.jpg"  title:@"呦呦鹿鸣 食野之萍"]];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"beauty.jpg" title:@"青青子衿 悠悠我心"]];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"helle.jpg" title:@"但为君故 沉吟至今"]];
    [self.newsArray addObject:[[News alloc]initWithPicUrl:@"wawa.jpg"  title:@"呦呦鹿鸣 食野之萍"]];
    
    // 下拉刷新
    [self.tableView addPullToRefreshWithActionHandler:^{
        [self.newsArray insertObject:[[News alloc]initWithPicUrl:@"helle.jpg" title:@"新增数据*****"] atIndex:0];
        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
    }];
    // 上拉刷新
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [self.newsArray addObject:[[News alloc]initWithPicUrl:@"helle.jpg" title:@"新增数据*****"]];
        [self.tableView reloadData];
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
    
    [self.view addSubview:self.tableView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"old = %@ , new = %@ ",[change objectForKey:NSKeyValueChangeOldKey], [change objectForKey:NSKeyValueChangeNewKey]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.newsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    NewsItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[NewsItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    News* news=[self.newsArray objectAtIndex:indexPath.row];
    [cell setImage:[news picUrl] setTitle:[news title]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.newsArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    //这里设置成100
    return 100;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
