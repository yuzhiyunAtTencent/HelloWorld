//
//  TestHitTestViewController.m
//  Helloworld
//
//  Created by  yuzhiyun on 2022/3/25.
//  Copyright © 2022 zhiyunyu. All rights reserved.
//

#import "TestHitTestViewController.h"

// tableview的subview在tableview视图外部，怎么让这个suview响应点击

@interface ParentView : UIView

@end

@implementation ParentView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (!view) {
        for (UIView *subview in self.subviews) {
//            CGPoint newPoint = [subview convertPoint:point fromView:self];
//            if (CGRectContainsPoint(subview.bounds, newPoint)) {
//                return subview;
//            }
//            被注释的代码也是可以的
            if (CGRectContainsPoint(subview.frame, point)) {
                return subview;
            }
        }
    }
    return view;
}

@end


@interface TestHitTestViewController ()

@end

@implementation TestHitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_click)]];
    
    UIView *tableview = [[ParentView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    tableview.backgroundColor = [UIColor redColor];
    [tableview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tableclick)]];
    
    [self.view addSubview:tableview];
    
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    btnView.backgroundColor = [UIColor greenColor];
    [btnView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_btnclick)]];
    [tableview addSubview:btnView];
}

- (void)_click {
    NSLog(@"hittest blue");
}

- (void)_tableclick {
    NSLog(@"hittest redColor");
}
- (void)_btnclick {
    NSLog(@"hittest greenColor");
}


@end

