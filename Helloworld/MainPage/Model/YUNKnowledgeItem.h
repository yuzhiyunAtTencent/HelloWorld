//
//  YUNKnowledgeItem.h
//  Helloworld
//
//  Created by zhiyunyu on 2019/12/31.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YUNKnowledgeItem : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *viewCtlName;

- (instancetype)initWithTitle:(NSString *)title viewCtlName:(NSString *)viewCtlName;

@end

NS_ASSUME_NONNULL_END
