//
//  main.m
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/6.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "News.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog([[NSNumber numberWithInt:0] boolValue] ? @"Yes" : @"No");
        NSLog([[NSNumber numberWithInt:1] boolValue] ? @"Yes" : @"No");
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
