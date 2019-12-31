//
//  WKWebView+Responder.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/8/7.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "WKWebView+Responder.h"

@implementation WKWebView (Responder)

- (BOOL)canPerformAction:(SEL)action withSender:(nullable id)sender {
//    if (action == @selector(share)) {
//        return YES;
//    }
    return NO;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)share {
    NSLog(@"share 被点击");
}


@end
