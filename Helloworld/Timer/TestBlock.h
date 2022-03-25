//
//  TestBlock.h
//  Helloworld
//
//  Created by  yuzhiyun on 2021/12/20.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestBlock : NSObject
@property (nonatomic, copy) dispatch_block_t ablock;
@end

NS_ASSUME_NONNULL_END
