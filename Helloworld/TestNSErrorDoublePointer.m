//
//  TestNSErrorDoublePointer.m
//  Helloworld
//
//  Created by  yuzhiyun on 2021/10/9.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "TestNSErrorDoublePointer.h"
#import "TestModel.h"

@implementation TestNSErrorDoublePointer

// 测试正确写法
+ (void)testFounction1 {
    TestModel *a = [[TestModel alloc] init];
    a.title = @"我是a";
    
    /* 函数是两个星星的，调用的时候参数需要带取地址符，代表传递的参数是指针a的地址，
     然后函数内部会对这个参数带上星号解引用（*model = b;），代表指针a,并且把新对象的地址赋值给指针a,让指针a指向新的对象地址，
     因此可以成功变更对象，
     这就是为什么NSError的用法里面，参数都是两个星星，调用的时候需要加上取地址符&
    */
    [self changeModelRight:&a];
    
    //打印的结果是：success:调用函数，函数内部修改a指向的对象，title=我是b
    NSLog(@"success:调用函数，函数内部修改a指向的对象，title=%@", a.title);
}

// 正确写法，参数有2个星号
+ (void)changeModelRight:(TestModel **)model {
    TestModel *b = [[TestModel alloc] init];
    b.title = @"我是b";
    
    *model = b;
}

//*************************************************************************************************************************************************************

/*
 
可以看出，函数内model指针和a指针是两个不同的指针，model是a的一份拷贝，但是指向了相同的对象，因此无法成功修改原指针指向的对象
2021-10-09 19:02:02.773120+0800 Helloworld[1381:409231] 错误写法：a对象的地址<TestModel: 0x280bc77e0>，a指针的地址1867305000
2021-10-09 19:02:02.773148+0800 Helloworld[1381:409231] 错误写法：model指针指向的对象的地址<TestModel: 0x280bc77e0>，model指针的地址1867304920
*/
// 测试错误写法
+ (void)testFounction2 {
    TestModel *a = [[TestModel alloc] init];
    a.title = @"我是a";
    NSLog(@"错误写法：a对象的地址%@，a指针的地址%i", a, &a);
    
    /* 函数是一个星星的，调用的时候参数是指针a，在函数内部，会拷贝一个新的指针也指向对象a,最后把新对象的地址赋值给新的指针，因此没有达到修改a的目的
     这就是为什么NSError的用法里面，参数都是两个星星，调用的时候需要加上取地址符&
    */
    [self changeModelError:a];
    
    //打印的结果是：fail:调用函数，函数内部修改a指向的对象，title=我是a
    NSLog(@"fail:调用函数，函数内部修改a指向的对象，title=%@", a.title);
}

// 错误写法,参数只有1个星号
+ (void)changeModelError:(TestModel *)model {
    TestModel *b = [[TestModel alloc] init];
    b.title = @"我是b";
    
    NSLog(@"错误写法：model指针指向的对象的地址%@，model指针的地址%i", model, &model);
    model = b;
}

@end
