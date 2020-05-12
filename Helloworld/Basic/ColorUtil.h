//
//  ColorUtil.h
//  Helloworld
//
//  Created by zhiyunyu on 2020/5/12.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Colors **/
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define HEX(rgb) RGB((rgb) >> 16 & 0xff, (rgb) >> 8 & 0xff, (rgb)&0xff)

NS_ASSUME_NONNULL_BEGIN

@interface ColorUtil : NSObject

+ (UIColor *)colorWithRGB:(NSUInteger)rgb;

+ (UIColor *)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)colorStr
                   defaultColor:(UIColor *)defaultColor;
@end

NS_ASSUME_NONNULL_END
