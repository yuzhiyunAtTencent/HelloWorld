//
//  UIImage+hook.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/8/12.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "UIImage+hook.h"
#import <objc/runtime.h>

@implementation UIImage (hook)

/*
 * 通过hook，让每次获取图片的时候，加上前缀icon_
 */
+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        
        Class selfClass = object_getClass([self class]); // 如果我们需要替换的函数是实例函数，而不是类函数，使用Class selfClass = [self class];
        SEL oriSEL = @selector(imageNamed:);
        Method oriMethod = class_getClassMethod(selfClass, oriSEL); // 实例函数用class_getInstanceMethod
        SEL cusSEL = @selector(myImageNamed:);
        Method cusMethod = class_getClassMethod(selfClass, cusSEL);
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
    });
}

+ (UIImage *)myImageNamed:(NSString *)name {
    NSString *newName = [NSString stringWithFormat:@"icon_%@", name];
    return [UIImage myImageNamed:newName];
}

@end
