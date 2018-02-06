//
//  UIScreen+YunUtils.h
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/6.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_DEFALUT_STATUSBAR_HEIGHT  (IS_IPhoneX ? (44.0) : (20.0))
#define SCREEN_BOUNDS ([[UIScreen mainScreen] qn_portraitBounds])
#define SCREEN_SIZE ([[UIScreen mainScreen] qn_portraitBounds].size)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] qn_portraitBounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] qn_portraitBounds].size.width)
#define SCREEN_SCALE ([UIScreen mainScreen].scale)

#define SCREEN_NOSTATUSBAR_HEIGHT \
([[UIScreen mainScreen] qn_portraitBounds].size.height - SCREEN_DEFALUT_STATUSBAR_HEIGHT)

#define IS_IPHONE_5_6_6PLUS (SCREEN_HEIGHT > 500.0f && SCREEN_HEIGHT <= 736.0f)
#define IS_IPHONE_5 (SCREEN_HEIGHT > 500.0f && SCREEN_HEIGHT <= 568.0f)
#define IS_IPHONE_LOWER_5 (SCREEN_HEIGHT < 500.0f && SCREEN_HEIGHT < 568.0f)
#define IS_IPHONE_6 (SCREEN_HEIGHT > 600.0f && SCREEN_HEIGHT <= 667.0f)
#define IS_IPHONE_6PLUS (SCREEN_HEIGHT > 700.0f && SCREEN_HEIGHT <= 736.0f)
#define IS_IPHONE_6_6PLUS (IS_IPHONE_6 || IS_IPHONE_6PLUS)
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && SCREEN_SCALE > 1.00f)
#define IS_IPhoneX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface UIScreen (YunUtils)

@property(nonatomic, readonly) CGRect qn_portraitBounds;
@property(nonatomic, readonly) CGRect qn_landscapeBounds;

- (CGRect)qn_boundsForOrientation:(UIInterfaceOrientation)orientation;

@end
