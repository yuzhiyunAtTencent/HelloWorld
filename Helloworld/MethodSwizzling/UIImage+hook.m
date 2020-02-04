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
        
        
        /* class_addMethod
         * Return Value：
         * YES if the method was added successfully, otherwise NO (for example, the class already contains a method implementation with that name).
         * 这里用于判断是否本类已经含有这个函数
         */
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        } else {
            // 实际会走到这里，因为class_addMethod返回了NO。
            // 交换方法的实现
            method_exchangeImplementations(oriMethod, cusMethod);
        }
    });
}

+ (UIImage *)myImageNamed:(NSString *)name {
    NSString *newName = [NSString stringWithFormat:@"icon_%@", name];
    // 注意，这里不会死循环，因为已经被交换实现了，如果调用imageNamed 才会真正的死循环
    return [UIImage myImageNamed:newName];
}

@end
