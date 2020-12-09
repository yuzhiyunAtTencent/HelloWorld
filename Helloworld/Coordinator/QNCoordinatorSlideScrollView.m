//
//  QNCoordinatorSlideScrollView.m
//  QQNews
//
//  Created by patrikhuang on 2020/6/19.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "QNCoordinatorSlideScrollView.h"

@implementation QNCoordinatorSlideScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    /// 返回YES使得该UIScrollView接收childScrollView的垂直滚动事件，返回NO是为了屏蔽QNPageView的手势，避免用户横向切换index的时候，整体页面产生上下晃动
    if ([self.otherGestureRecognizers containsObject:otherGestureRecognizer]) {
        return NO;
    }
    return YES;
}

@end
