//
//  ColorUtil.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/5/12.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "ColorUtil.h"



@implementation ColorUtil
+ (UIColor *)colorWithRGB:(NSUInteger)rgb {
    return [self colorWithRGB:rgb alpha:1];
}

+ (UIColor *)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha {
    UIColor *color;
    color = [HEX(rgb) colorWithAlphaComponent:alpha];
    return color;
}

// 如果是8位，前2位是透明度
+ (UIColor *)colorWithHexString:(NSString *)colorStr
                   defaultColor:(UIColor *)defaultColor {
    //去掉字符串首位的空格，并且返回新的字符串
    NSString *cString =
            [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return defaultColor ? defaultColor : [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6 && [cString length] != 8)
        return defaultColor ? defaultColor : [UIColor clearColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;

    // a
    NSString *aString = @"FF";
    if ([cString length] == 8) {
        aString = [cString substringWithRange:range];
        range.location += 2;
    }

    // r
    NSString *rString = [cString substringWithRange:range];
    // g
    range.location += 2;
    NSString *gString = [cString substringWithRange:range];
    // b
    range.location += 2;
    NSString *bString = [cString substringWithRange:range];
    // Scan values  将16进制数转换为10进制  分别存到r,g,b中
    unsigned int a, r, g, b;
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return  [UIColor colorWithRed:((float)r / 255.0f)
                            green:((float)g / 255.0f)
                             blue:((float)b / 255.0f)
                            alpha:((float)a / 255.0f)];
}
@end
