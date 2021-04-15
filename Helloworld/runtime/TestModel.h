//
//  TestModel.h
//  Helloworld
//
//  Created by yuzhiyun on 2021/4/15.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUNKnowledgeItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface TestModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, assign) BOOL isMan;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, strong) YUNKnowledgeItem *knowledgeItem;

@end

NS_ASSUME_NONNULL_END
