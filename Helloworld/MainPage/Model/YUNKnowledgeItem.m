//
//  YUNKnowledgeItem.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/12/31.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "YUNKnowledgeItem.h"

@implementation YUNKnowledgeItem

- (instancetype)initWithTitle:(NSString *)title viewCtlName:(NSString *)viewCtlName {
    self = [super init];
    if (self) {
        self.title = title;
        self.viewCtlName = viewCtlName;
    }
    return self;
}
@end
