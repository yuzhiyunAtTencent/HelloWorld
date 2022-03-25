//
//  TransformViewController.m
//  Helloworld
//
//  Created by  yuzhiyun on 2022/2/17.
//  Copyright © 2022 zhiyunyu. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()
@property (nonatomic, strong) UIView *demoView;
@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.demoView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2, (SCREEN_WIDTH - 100) / 2 , 100, 100)];
    self.demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.demoView];
    [self testTransform];
}

- (void)testTransform {
    int n =5;
    int a[n][n];
    a[4][4] = 9;
    
//    printf("yzy %d %d", a[4][4], a[3][0]);
    
//    NSLog(@"newPoint x=%@, y=%@", @(newPoint.x), @(newPoint.y));
    
    _demoView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:1.0f animations:^{
            _demoView.transform = CGAffineTransformMakeTranslation(100, 100);
        }];
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeTranslation(100, 100);
    CGPoint newPoint = CGPointApplyAffineTransform(CGPointMake(1, 2), transform);
    NSLog(@"yzy newPoint x=%@, y=%@", @(newPoint.x), @(newPoint.y));
}

@end
