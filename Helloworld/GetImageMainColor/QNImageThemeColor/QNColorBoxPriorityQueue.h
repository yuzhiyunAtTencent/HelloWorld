//
//  QNColorBoxPriorityQueue.h
//  Helloworld
//
//  Created by zhiyunyu on 2020/3/5.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNColorBox.h"

NS_ASSUME_NONNULL_BEGIN

#define QN_THEHE_COLOR_MAX_COUNT  17

@interface QNColorBoxPriorityQueue : NSObject

- (void)addColorBox:(QNColorBox *)box;

- (QNColorBox *)objectAtIndex:(NSInteger)i;

- (QNColorBox *)poll;

- (NSUInteger)count;

- (NSMutableArray*)getColorBoxArray;

@end

NS_ASSUME_NONNULL_END
