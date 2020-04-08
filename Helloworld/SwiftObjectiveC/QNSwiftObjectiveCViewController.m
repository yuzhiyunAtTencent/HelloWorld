//
//  SwiftObjectiveCViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/4/8.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "QNSwiftObjectiveCViewController.h"
#import "Helloworld-Bridging-Header.h"

@interface QNSwiftObjectiveCViewController ()

@end

@implementation QNSwiftObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(_click)]];
}

- (void)_click {
    QNSwiftObjectiveCViewController *viewController = [[QNSwiftObjectiveCViewController alloc] init];
    NSLog(@"%@", viewController);
}

@end
