//
//  UIScreen+YunUtils.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/6.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "UIScreen+YunUtils.h"

@implementation UIScreen (YunUtils)

- (CGRect)qn_portraitBounds {
    static dispatch_once_t once;
    static CGRect bounds;
    
    dispatch_once(&once,
                  ^{
                      bounds = self.bounds;
                      if (bounds.size.width > bounds.size.height)
                          bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);  // switch width and height
                  });
    
    return bounds;
}

- (CGRect)qn_landscapeBounds {
    static dispatch_once_t once;
    static CGRect bounds;
    
    dispatch_once(&once,
                  ^{
                      bounds = self.bounds;
                      if (bounds.size.width < bounds.size.height)
                          bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);  // switch width and height
                  });
    
    return bounds;
}

- (CGRect)qn_boundsForOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation))
        return [self qn_portraitBounds];
    else
        return [self qn_landscapeBounds];
}

@end
