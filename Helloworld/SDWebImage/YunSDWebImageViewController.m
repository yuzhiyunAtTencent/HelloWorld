//
//  YunSDWebImageViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/7/19.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "YunSDWebImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface YunSDWebImageViewController ()

@end

@implementation YunSDWebImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 400)];
    [self.view addSubview:imageView];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/rs/SDWebImage/master/Docs/SDWebImageClassDiagram.png"]];
    
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
