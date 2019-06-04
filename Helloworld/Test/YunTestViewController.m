//
//  YunTestViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/11/6.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import "YunTestViewController.h"
#import "News.h"
#import "CYLDeallocBlockExecutor.h"

@interface YunTestViewController ()

@end

@implementation YunTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(mainthreadOperation) withObject:nil afterDelay:1];
    
    [[NSOperationQueue new] addOperationWithBlock:^{
        [self performSelector:@selector(delayOperation) withObject:nil afterDelay:1];
        [self performSelector:@selector(operation) withObject:nil];
    }];
    
    News *news = [[News alloc] initWithPicUrl:@"" title:@""];
    NSLog(@"");
    [news cyl_willDeallocWithSelfCallback:^(__unsafe_unretained id owner, NSUInteger identifier) {
        NSLog(@"cyl_willDeallocWithSelfCallback");
    }];
    
    [self testReadJsonFile];
    
}

- (void)delayOperation {
    NSLog(@"delayOperation");
}

- (void)operation {
    NSLog(@"operation");
}

- (void)mainthreadOperation {
    NSLog(@"mainthreadOperation");
}

- (void)testReadJsonFile {
    NSDictionary *resultDic = [self.class readLocalFileWithName:@"NewsList"];
    NSLog(@"%@", @(resultDic.count));
}

// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
