//
//  MainViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/6.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import "MainViewController.h"
#import "NewsListTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super loadView];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image=[UIImage imageNamed:@"back.jpg"];
    [self.view addSubview:imageView];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"开启非凡之旅" forState:UIControlStateNormal];
    [enterMainButton addTarget:self action:@selector(haha:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:enterMainButton];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)haha:(id)sender{
//    NSLog(@"btn被点击了");
    NewsListTableViewController *nextPage= [[NewsListTableViewController alloc]init];
    nextPage.hidesBottomBarWhenPushed=YES;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:nextPage animated:YES];
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


