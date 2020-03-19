//
//  UIImage+ThemeColor.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/3/5.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "UIImage+ThemeColor.h"

@implementation UIImage (ThemeColor)

- (void)getThemeColor:(QNGetColorBlock)colorBlock {
    [[QNThemeColorExtracter sharedInstance] extractColorsFromImage:self
                                                        colorBlock:colorBlock];
}

@end
