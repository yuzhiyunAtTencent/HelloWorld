//
//  QNCoordinatorView.h
//  CoordinatorSlideDemo
//
//  Created by patrikhuang on 2020/6/30.
//  Copyright © 2020 patrikhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNCoordinatorDefine.h"

@class QNCoordinatorView, QNCoordinatorSlideScrollView;

@protocol QNCoordinatorSlideDataSource<NSObject>

@required
/// 获取品字型头部
- (UIView *_Nullable)viewForHeader;
/// 获取品字型中间menu
- (UIView *_Nullable)viewForMenu;
/// 获取品字型中间内容区域，是一个支持横向滚动的view,类似于QNPageView,
- (UIView<QNCoordinatorSlideContentViewProtocol> *_Nonnull)viewForContent;
/// 获取品字型导航栏高度
- (CGFloat)headerForNavigationBar;
// 头部是否紧贴屏幕上边缘
- (BOOL)isHeaderAgainstScreenTopEdge;
/// 获取品字型头部高度
- (CGFloat)heightForHeader;
/// 获取品字型中间menu高度
- (CGFloat)heightForMenu;
/// 获取品字型中间内容区域高度
- (CGFloat)heightForContent;
@end

@protocol QNCoordinatorSlideDelegate<NSObject>
/// 品字型头部正在视野中滚动
/// @param contentOffsetY parentscrollview的contentOffsetY
- (void)headerViewDidScroll:(CGFloat)contentOffsetY;
@end

@interface QNCoordinatorView : UIView

@property(nonatomic, weak, nullable) id <QNCoordinatorSlideDataSource> dataSource;
@property(nonatomic, weak, nullable) id <QNCoordinatorSlideDelegate> delegate;

- (void)reloadData;

@end
