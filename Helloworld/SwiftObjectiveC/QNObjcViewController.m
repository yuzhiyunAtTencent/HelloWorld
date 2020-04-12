//
//  SwiftObjectiveCViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/4/8.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "QNObjcViewController.h"
#import "Helloworld-Swift.h" // 导入 productName-Swift.h, 才可以在oc中访问到 swift,可以点进去看底部，包含了我们熟悉的oc类声明的代码

@interface QNObjcViewController ()

@end

@implementation QNObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(_click)]];
}

- (void)_click {
    QNSwiftViewController *viewController = [[QNSwiftViewController alloc] init];
    [viewController testSwiftFunction];
    [viewController swiftSayHelloWithHelloMsg:@"oc调用swift,带参数（）注意函数名变化"];
    
    viewController.titleStr = @"titleFromObjc";
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
