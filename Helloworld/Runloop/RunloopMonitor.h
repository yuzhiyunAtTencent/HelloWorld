//
//  RunloopMonitor.h
//  Helloworld
//
//  Created by zhiyunyu on 2019/7/22.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunloopMonitor : NSObject

+ (instancetype)shareInstance;
- (void)beginMonitor;

@end

NS_ASSUME_NONNULL_END
