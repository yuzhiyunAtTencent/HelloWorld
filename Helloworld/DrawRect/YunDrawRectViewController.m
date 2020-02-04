//
//  YunDrawRectViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/8/6.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "YunDrawRectViewController.h"

@interface YunStockFlagView : UIView

@end

@implementation YunStockFlagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width / 2, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.strokeColor = [UIColor greenColor].CGColor;
    
    [self.layer addSublayer:layer];
}

@end

@interface YunDrawRectViewController ()

@end

@implementation YunDrawRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YunStockFlagView *flagView = [[YunStockFlagView alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    [self.view addSubview:flagView];
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
