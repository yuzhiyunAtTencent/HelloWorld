//
//  TestEqualViewController.m
//  Helloworld
//
//  Created by yuzhiyun on 2021/4/15.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "TestEqualViewController.h"
#import <objc/runtime.h>
#import "TestModel.h"
#import <UIKit/UITabBarController.h>

@interface TestEqualViewController ()

@end

@implementation TestEqualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarItem.title = @"ss";
    TestModel *a = [TestModel new];
//    a.age = 10;
////    a.isMan = NO;
//    a.title = @"jjj";
    
    TestModel *b = [TestModel new];
//    b.age = 10;
////    b.isMan = YES;
//    b.title = @"jjj";

    
    [self compareObject:a withAnother:b propertyClass:[a class]];

//    [self systemEqual];
}

//- (void)systemEqual {
//    TestModel *a = [TestModel new];
//    a.age = 10;
//    a.isMan = NO;
//    a.title = @"jjje";
//
//    TestModel *b = [TestModel new];
//    b.age = 10;
//    b.isMan = YES;
//    b.title = @"jjj";
//
//    NSLog(@"%@", @([a isEqual:b]));
//}


/// 对比两个object内容是否相同（手动写系统提供的对象的equals函数，需要一个个写每一个属性，比较麻烦，因此有这里的想法）
/// @param object object description
/// @param anotherObject another description
/// @return YES代表对象内容相同，NO代表不相同
- (BOOL)compareObject:(NSObject *)object
           withAnother:(NSObject *)anotherObject
         propertyClass:(Class)propertyClass {
    if (![NSStringFromClass([object class]) isEqual:NSStringFromClass([anotherObject class])]) {
        return NO;
    }
    
    unsigned int count;
    // 经过验证，发现KN提供的类无法获取到propertyList，只有oc自己的类可以获取到
    objc_property_t *propertyList = class_copyPropertyList(propertyClass, &count);
    NSLog(@"property *******************************************************************%@", NSStringFromClass(propertyClass));
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *propertyType = @(property_copyAttributeValue(property, "T"));
        
        id propertyValue = [object valueForKey:propertyName];
        id anotherPropertyValue = [anotherObject valueForKey:propertyName];
        
        NSLog(@"property        : %@ ,%@ ,%@", propertyName, propertyType, propertyValue);
        NSLog(@"property another: %@ ,%@ ,%@", propertyName, propertyType, anotherPropertyValue);
        
        // todo 此处还得判断别的类型，总之，@符号开头的都是对象,如果是自定义复杂对象，递归调用当前函数即可，如果是字典、数组、set等等，还有取出内容再递归调用当前函数
        if ([propertyType isEqual:@"@\"NSString\""]) {
            NSLog(@"字符串");
            if (![(NSString *)propertyValue isEqual:(NSString *)anotherPropertyValue]) {
                NSLog(@"%@不相等", propertyName);
                return NO;
            }
        }
        
        const char *type = property_getAttributes(property);
        NSString * typeString = [NSString stringWithUTF8String:type];
        NSArray * attributes = [typeString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributes objectAtIndex:0];
        NSString * pType = [typeAttribute substringFromIndex:1];
        const char *t = [pType UTF8String];
        
        // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1%20%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%E2%80%94%20%E7%89%88%E6%9D%83%E5%A3%B0%E6%98%8E%EF%BC%9A%E6%9C%AC%E6%96%87%E4%B8%BACSDN%E5%8D%9A%E4%B8%BB%E3%80%8CJohnny.Cheung%E3%80%8D%E7%9A%84%E5%8E%9F%E5%88%9B%E6%96%87%E7%AB%A0%EF%BC%8C%E9%81%B5%E5%BE%AACC%204.0%20BY-SA%E7%89%88%E6%9D%83%E5%8D%8F%E8%AE%AE%EF%BC%8C%E8%BD%AC%E8%BD%BD%E8%AF%B7%E9%99%84%E4%B8%8A%E5%8E%9F%E6%96%87%E5%87%BA%E5%A4%84%E9%93%BE%E6%8E%A5%E5%8F%8A%E6%9C%AC%E5%A3%B0%E6%98%8E%E3%80%82%20%E5%8E%9F%E6%96%87%E9%93%BE%E6%8E%A5%EF%BC%9Ahttps://blog.csdn.net/u013538542/article/details/74179210
        if (strcmp(t, @encode(char)) == 0) {
            type = "char";
        } else if (strcmp(t, @encode(int)) == 0 ||
                   strcmp(t, @encode(unsigned int)) == 0 ||
                   strcmp(t, @encode(short)) == 0 ||
                   strcmp(t, @encode(unsigned short)) == 0 ||
                   strcmp(t, @encode(long)) == 0 ||
                   strcmp(t, @encode(unsigned long)) == 0 ||
                   strcmp(t, @encode(long long)) == 0 ||
                   strcmp(t, @encode(unsigned long long)) == 0) {
            
        } else if (strcmp(t, @encode(unsigned char)) == 0) {
            type = "unsigned char";
        } else if (strcmp(t, @encode(float)) == 0) {
            type = "float";
        } else if (strcmp(t, @encode(double)) == 0) {
            type = "double";
        } else if (strcmp(t, @encode(_Bool)) == 0 || strcmp(t, @encode(bool)) == 0) {
            type = "BOOL";
        } else if (strcmp(t, @encode(char *)) == 0) {
            type = "char *";
        } else if (strcmp(t, @encode(id)) == 0) {
            type = "id";
        } else if (strcmp(t, @encode(Class)) == 0) {
            type = "Class";
        } else if (strcmp(t, @encode(SEL)) == 0) {
            type = "SEL";
        } else {
            type = "";
        }
    }
    
    
    free(propertyList);
    
    if (![NSStringFromClass([propertyClass superclass]) isEqual:@"NSObject"]) {
        // 由于class_copyPropertyList无法获取到superclass的属性，因此还得递归查询继承链
        return [self compareObject:object withAnother:anotherObject propertyClass:[object superclass]];
    }
    return YES;
}

@end
