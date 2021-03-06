//
//  SwiftObjectiveCViewController.h
//  Helloworld
//
//  Created by zhiyunyu on 2020/4/8.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YunBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNOCProtocol <NSObject>
@required
- (void)doSomething:(NSString *)something;
@end

@interface QNObjcViewController : YunBasicViewController

@end

NS_ASSUME_NONNULL_END
