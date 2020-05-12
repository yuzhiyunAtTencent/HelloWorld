//
//  QNTestCategoryChildController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/4/28.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "QNTestCategoryChildController.h"

@interface QNTestCategoryChildController ()

@end

@implementation QNTestCategoryChildController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self hello];
}

- (void)hello {
    NSLog(@"子类");
}

@end
