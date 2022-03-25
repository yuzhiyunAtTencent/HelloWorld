//
//  ViewController.m
//  Helloworld
//
//  Created by  yuzhiyun on 2021/12/20.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"


@interface ViewController ()
@property (strong, nonatomic) dispatch_semaphore_t semaphore;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
}

@end
