//
//  StrongWeakBlcokViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/7/16.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "StrongWeakBlcokViewController.h"

typedef void(^test_block)(void);

@interface WeakTestObject : NSObject
@property (copy,nonatomic) test_block block;
@end

@implementation WeakTestObject
@end

@interface StrongWeakBlcokViewController ()

@end

@implementation StrongWeakBlcokViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WeakTestObject *obj = [[WeakTestObject alloc] init];
    obj.block = ^{
        NSLog(@"execute block in obj");
    };

    // 会crash,因为
    __weak __typeof(obj) wObj = obj;
    dispatch_block_t b = ^{
        __strong __typeof(wObj) sObj = wObj;
        sObj.block();
    };
    obj = nil;
    b();
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
