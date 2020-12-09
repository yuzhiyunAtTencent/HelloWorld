//
//  QNCoordinatorSlideScrollView.h
//  QQNews
//
//  Created by patrikhuang on 2020/6/19.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 该UIScrollView是品字型框架最底层页的container,需要接收childScrollView的垂直滚动事件
@interface QNCoordinatorSlideScrollView : UIScrollView

@property(nonatomic, copy) NSArray<UIGestureRecognizer *> *otherGestureRecognizers;

@end
