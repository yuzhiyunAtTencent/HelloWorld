//
//  Student.h
//  Helloworld
//
//  Created by  yuzhiyun on 2021/12/20.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Study)();
@interface Student : NSObject
@property (copy , nonatomic) NSString *name;
@property (copy , nonatomic) Study study;
@end

NS_ASSUME_NONNULL_END
