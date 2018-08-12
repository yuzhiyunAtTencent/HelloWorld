//
//  YunMethodSwizzlingViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/8/12.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "YunMethodSwizzlingViewController.h"
#import "UIImage+hook.h"

@interface YunMethodSwizzlingViewController ()

@property(nonatomic, strong) UIImageView *avatarImage;
@property(nonatomic, strong) UIImageView *iconAvatarImage;

@end

@implementation YunMethodSwizzlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 由于使用了method swizzle来替换函数，这个反而获取不到图片
    _avatarImage = ({
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
         image.backgroundColor = [UIColor grayColor];
        [image setImage:[UIImage imageNamed:@"icon_hello.png"]];
        image;
    });
    [self.view addSubview:_avatarImage];
    
    // 这个获取的到图片,因为method swizzle 给图片追加了前缀icon_
    _iconAvatarImage = ({
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
         image.backgroundColor = [UIColor grayColor];
        [image setImage:[UIImage imageNamed:@"hello.png"]];
        image;
    });
    [self.view addSubview:_iconAvatarImage];
    
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
