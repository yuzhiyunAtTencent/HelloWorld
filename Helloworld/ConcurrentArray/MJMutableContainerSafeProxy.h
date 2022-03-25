//
//  MJMutableContainerSafeProxy.h
//  Helloworld
//
//  Created by  yuzhiyun on 2021/11/15.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJMutableContainerSafeProxy : NSProxy

+ (NSMutableDictionary *)dictionary;
+ (NSMutableArray *)array;
+ (NSMutableSet *)set;

@end


NS_ASSUME_NONNULL_END
