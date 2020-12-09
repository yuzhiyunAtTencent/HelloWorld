//
//  QNCoordinatorSlideDefine.h
//  QQNews
//
//  Created by patrikhuang on 2020/6/26.
//  Copyright © 2020 Tencent. All rights reserved.
//

#ifndef QNCoordinatorSlideDefine_h
#define QNCoordinatorSlideDefine_h

@protocol QNCoordinatorPageViewProtocol,
          QNCoordinatorSlideContentViewProtocol,
          QNPageViewContentViewProtocol;

/// 单独每个contentView的pageView需要实现的协议
@protocol QNCoordinatorPageViewProtocol <NSObject>
- (UIScrollView *)scrollViewInCoordinatorPageView;
@end

@protocol QNCoordinatorPageIndexChangeProtocol <NSObject>
- (void)indexDidChange:(NSUInteger)oldIndex newIndex:(NSUInteger)newIndex;
@end

@protocol QNCoordinatorSlideContentViewProtocol <NSObject>
@property(nonatomic, weak) id<QNCoordinatorPageIndexChangeProtocol> indexChangeDelegate;
- (id<QNPageViewContentViewProtocol>)contentForIndex:(NSUInteger)index;
- (UIScrollView *)scrollViewOfPageView;
@end

#endif /* QNCoordinatorSlideDefine_h */

