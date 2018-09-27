//
//  YunSDWebImageViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/7/19.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "YunSDWebImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define IMAGE_URL @"http://puep.qpic.cn/coral/Q3auHgzwzM4fgQ41VTF2rJVmkJxEfgQqn3tmZja9RibGElm27800WvQ/640"

@interface YunSDWebImageViewController ()

@end

@implementation YunSDWebImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 500)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:IMAGE_URL]];
    
    [imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCompleteImageView)];
    [imageView addGestureRecognizer:gesture];

}

- (void)showCompleteImageView {
    [self addImageOnViewWithImage];
}

-(void)addImageOnViewWithImage{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scroll.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scroll];

    // 这个长图的高度一般来说是服务器下发的
    scroll.contentSize = CGSizeMake(SCREEN_WIDTH, 1400);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 1400)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView sd_setImageWithURL:[NSURL URLWithString:IMAGE_URL]];
    
    [scroll addSubview:imageView];
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
