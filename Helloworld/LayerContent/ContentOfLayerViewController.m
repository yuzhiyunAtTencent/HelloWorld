//
//  ContentOfLayerViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/10/17.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "ContentOfLayerViewController.h"

@interface ContentOfLayerViewController ()

@end

@implementation ContentOfLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"pikaqiu" ofType:@"png" inDirectory:@"Image.bundle/home"];
//
//    // 使用UIView也可以展示图片,测试过的确这样就可以展示了
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
//    view.layer.contents = (id)([UIImage imageWithContentsOfFile:imagePath].CGImage);
//    [self.view addSubview:view];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"pikaqiu" ofType:@"png" inDirectory:@"Image.bundle/home"];
    
    // 使用UIView也可以展示图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
//    imageView.layer.cornerRadius = 50;
//    imageView.layer.masksToBounds = YES;
//    imageView.backgroundColor = [UIColor redColor];
    
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:imageView.frame.size.width] addClip];
    [imageView drawRect:imageView.bounds];
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();

    [self.view addSubview:imageView];
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
