//
//  QNCoordinatorView.m
//  CoordinatorSlideDemo
//
//  Created by patrikhuang on 2020/6/30.
//  Copyright © 2020 patrikhuang. All rights reserved.
//

#import "QNCoordinatorView.h"
#import "QNCoordinatorSlideScrollView.h"

@interface QNCoordinatorView () <UIScrollViewDelegate, QNCoordinatorPageIndexChangeProtocol>

@property(nonatomic, assign) BOOL needsReload;
@property(nonatomic, assign) CGSize contentSize;
@property(nonatomic, assign) NSUInteger currentIndex;

@property(nonatomic, strong) QNCoordinatorSlideScrollView *scrollView;
@property(nonatomic, weak) UIView *navigationView;
@property(nonatomic, weak) UIView *headerView;
@property(nonatomic, weak) UIView *middleView;
@property(nonatomic, weak) UIView<QNCoordinatorSlideContentViewProtocol> *contentView;

@property(nonatomic, assign) BOOL canParentViewScroll;
@property(nonatomic, assign) BOOL canChildViewScroll;

@end

@implementation QNCoordinatorView
/*
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        
        self.canParentViewScroll = YES;
        self.canChildViewScroll = NO;
    }
    return self;
}

- (void)dealloc {
    [self.scrollView qn_unbindObserver:self];
    
    id<QNPageViewContentViewProtocol> scrollViewImp = [self.contentView contentForIndex:self.currentIndex];
    UIScrollView *pageScrollView = [scrollViewImp scrollViewInCoordinatorPageView];
    [pageScrollView qn_unbindObserver:self];
}

- (void)reloadData {
    [self p_updateComponents];
    [self p_setContentSize];

    [self p_layoutCoordinatorSlideView];
}

// 交换滚动权限的分割点
- (CGFloat)headerStickyHeight {
    CGFloat height = 0;
    if ([self.dataSource isHeaderAgainstScreenTopEdge]) {
        height = kQNNavigationCommonHeight;
    }

    return [self.dataSource heightForHeader] - height;
}

- (void)p_updateComponents {
    self.navigationView = nil;
    self.headerView = nil;

    if ([self.delegate respondsToSelector:@selector(viewForHeader)]) {
        self.headerView = [self.dataSource viewForHeader];
        [self.scrollView addSubview:self.headerView];
    }
    if ([self.delegate respondsToSelector:@selector(viewForMenu)]) {
        self.middleView = [self.dataSource viewForMenu];
        [self.scrollView addSubview:self.middleView];
    }
    if ([self.delegate respondsToSelector:@selector(viewForContent)]) {
        self.contentView = [self.dataSource viewForContent];
        self.contentView.indexChangeDelegate = self;
        [self.scrollView addSubview:self.contentView];
    }
    
    UIScrollView *contentScrollView = [self.contentView scrollViewOfPageView];
    self.scrollView.otherGestureRecognizers = [contentScrollView.gestureRecognizers copy];
}

- (void)p_setContentSize {
    CGFloat headerForNavigationBar = [self.dataSource headerForNavigationBar];
    CGFloat headerHeight = self.headerView ? [self.dataSource heightForHeader] : 0;
    CGFloat middleHeight = self.middleView ? [self.dataSource heightForMenu] : 0;
    CGFloat contentHeight = [self.dataSource heightForContent];
    
    CGFloat totalHeight = headerForNavigationBar + headerHeight + middleHeight + contentHeight;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, totalHeight);
}

- (void)p_layoutCoordinatorSlideView {
    CGFloat offsetY = [self.dataSource headerForNavigationBar];
    [self.headerView setFrame:(CGRect){0, offsetY, self.headerView.bounds.size}];
    offsetY += self.headerView.bounds.size.height;
    [self.middleView setFrame:(CGRect){0, offsetY, self.middleView.bounds.size}];
    offsetY += self.middleView.bounds.size.height;
    [self.contentView setFrame:(CGRect){0, offsetY, self.contentView.bounds.size}];
}
										
#pragma mark - 协同滚动逻辑
- (void)p_setScrollView:(UIScrollView *)scrollView contentOffsetY:(CGFloat)offsetY {
    if (offsetY != scrollView.contentOffset.y) {
        [scrollView setContentOffset:(CGPoint){scrollView.contentOffset.x, offsetY}];
    }
}

// 初始值canParentViewScroll = YES
- (void)parentScrollViewDidScroll {
    CGFloat parentContentOffsetY = self.scrollView.contentOffset.y;
    CGFloat headerStickyHeight = [self headerStickyHeight];
    
    if (!self.canParentViewScroll) {
        [self p_setScrollView:self.scrollView contentOffsetY:headerStickyHeight];
        self.canChildViewScroll = YES;
    } else {
        if (parentContentOffsetY >= headerStickyHeight) {
            // 滚动权限交换
            self.canParentViewScroll = NO;
            self.canChildViewScroll = YES;
            [self p_setScrollView:self.scrollView contentOffsetY:headerStickyHeight];
        } else if (parentContentOffsetY <= 0) {
            [self p_setScrollView:self.scrollView contentOffsetY:0];
        }
    }
    
    // 通知业务层处理navigation的变化
    if ([self.delegate respondsToSelector:@selector(headerViewDidScroll:)]) {
        [self.delegate headerViewDidScroll:self.scrollView.contentOffset.y];
    }
}

// 初始值canChildViewScroll = NO
- (void)childScrollViewDidScroll:(UIScrollView *)childScrollView {
    CGFloat parentContentOffsetY = self.scrollView.contentOffset.y;
    CGFloat childContentOffsetY = childScrollView.contentOffset.y;
    
    if (!self.canChildViewScroll) {
        // 支持子页面的下拉刷新
        if (childContentOffsetY <= 0
            && fequal(parentContentOffsetY, 0)) {
        } else {
            [self p_setScrollView:childScrollView contentOffsetY:0];
        }
    } else {
        if (childContentOffsetY <= 0
            && parentContentOffsetY > 0
            && parentContentOffsetY <= [self headerStickyHeight]) {
            // 滚动权限交换
            self.canParentViewScroll = YES;
            self.canChildViewScroll = NO;
            [self p_setScrollView:childScrollView contentOffsetY:0];
        }
    }
}

#pragma mark - QNCoordinatorPageIndexChangeProtocol
// pageview切换index的时候，开始监听当前page的ScrollView的contentOffset的变化，从而处理协同滚动逻辑
- (void)indexDidChange:(NSUInteger)oldIndex newIndex:(NSUInteger)newIndex {
    self.currentIndex = newIndex;
    
    id<QNPageViewContentViewProtocol> oldScrollViewImp = [self.contentView contentForIndex:oldIndex];
    UIScrollView *oldPageScrollView = [oldScrollViewImp scrollViewInCoordinatorPageView];
    [oldPageScrollView qn_unbindObserver:self];
    
    id<QNPageViewContentViewProtocol> newScrollViewImp = [self.contentView contentForIndex:newIndex];
    UIScrollView *newPageScrollView = [newScrollViewImp scrollViewInCoordinatorPageView];
    
    if (self.scrollView.contentOffset.y >= 0
        && self.scrollView.contentOffset.y < [self headerStickyHeight]) {
        // 要保证header展示的时候，childScrollView的offsetY = 0
        [newPageScrollView setContentOffset:CGPointMake(newPageScrollView.contentOffset.x, 0)];
    }
    
    [newPageScrollView qn_unbindObserver:self];
    @weakify(self)
    [newPageScrollView qn_bindObserver:self
                               keyPath:@"contentOffset"
                              callback:^(QNKVOInfo *kvoInfo, NSObject *oldValue, NSObject *newValue) {
        @strongify(self);
        [self childScrollViewDidScroll:newPageScrollView];
    }];
}

#pragma mark - getter
- (QNCoordinatorSlideScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[QNCoordinatorSlideScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
        [_scrollView setPagingEnabled:NO];
        [_scrollView setScrollEnabled:YES];
        _scrollView.delegate = self;
        
        @weakify(self);
        [_scrollView qn_bindObserver:self keyPath:@"contentOffset" callback:^(QNKVOInfo *kvoInfo, NSObject *oldValue, NSObject *newValue) {
            @strongify(self);
            [self parentScrollViewDidScroll];
        }];
    }
    return _scrollView;
}
*/
@end
