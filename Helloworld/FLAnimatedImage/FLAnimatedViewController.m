//
//  FLAnimatedViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/9/24.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "FLAnimatedViewController.h"
#import <FLAnimatedImage/FLAnimatedImage.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <SDWebImage/FLAnimatedImageView+WebCache.h>

@interface FLAnimatedViewController ()

@end

@implementation FLAnimatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    [imageView sd_setImageWithURL:
     [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]];
    
    imageView.frame = CGRectMake(50.0, 200.0, 100.0, 100.0);
    [self.view addSubview:imageView];
}

@end
