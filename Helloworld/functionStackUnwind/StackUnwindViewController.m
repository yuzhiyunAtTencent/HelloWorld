//
//  StackUnwindViewController.m
//  Helloworld
//
//  Created by  yuzhiyun on 2022/4/5.
//  Copyright © 2022 zhiyunyu. All rights reserved.
//

#import "StackUnwindViewController.h"
#include <dlfcn.h>
#include <libunwind.h>

@interface StackUnwindViewController ()

@end

@implementation StackUnwindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self a];
}

- (void)a {
    [self b];
}

- (void)b {
    [self c];
}

- (void)c {
    NSLog(@"c");
}





















- (void)hello {
    [self print];
}

- (void)print {
    NSLog(@"开始打印：[NSThread callStackSymbols]");
    NSLog(@"%@", [NSThread callStackSymbols]);

    NSLog(@"===== 分隔符 =====");
//    fastUnwind_frame();
//    fastUnwind();
}

void fastUnwind_frame() {
    typedef uintptr_t frame_data_addr_t;
    
    struct frame_data {
        struct frame_data *frame_addr_next;
        frame_data_addr_t *ret_addr;
    };
    struct frame_data *fp = __builtin_frame_address(0);
    for (;;) {
        struct frame_data *next_fp = fp->frame_addr_next;
        if (next_fp <= fp) break;
        // 实践表明，fp->ret_addr就是lr寄存器的值，fp->frame_addr_next就是上一个函数的fp(断点停在上一个函数执行 register read查看下fp即可，值是相等的)
//        dumpAddress((fp->ret_addr));
        printf("0x%016lx \n", (unsigned long)(fp->ret_addr));
        fp = next_fp;
    }
}

void fastUnwind() {
    /* __builtin_frame_address, the address of the function frame
     * 参数代表call stack的层级，0就是当前函数，1就是当前函数的caller，以此类推
     * https://www.daemon-systems.org/man/__builtin_frame_address.3.html
     * 注意还有一个__builtin_return_address 代表函数返回地址，和__builtin_frame_address是不一样的
     
     
     https://gcc.gnu.org/onlinedocs/gcc/Return-Address.html
     This function is similar to __builtin_return_address, but it returns the address of the function frame rather than the return address of the function. Calling __builtin_frame_address with a value of 0 yields the frame address of the current function, a value of 1 yields the frame address of the caller of the current function, and so forth.

     The frame is the area on the stack that holds local variables and saved registers. The frame address is normally the address of the first word pushed on to the stack by the function. However, the exact definition depends upon the processor and the calling convention. If the processor has a dedicated frame pointer register, and the function has a frame, then __builtin_frame_address returns the value of the frame pointer register.

     On some machines it may be impossible to determine the frame address of any function other than the current one; in such cases, or when the top of the stack has been reached, this function returns 0 if the first frame pointer is properly initialized by the startup code.

     Calling this function with a nonzero argument can have unpredictable effects, including crashing the calling program. As a result, calls that are considered unsafe are diagnosed when the -Wframe-address option is in effect. Such calls should only be made in debugging situations.
     */
    void **fp = __builtin_frame_address(0);
    
    for (;;) {
        void **next_fp = *fp;
        if (next_fp <= fp) break;
        dumpAddress(*(fp + 1));
        // printf("%p\n", *(fp+1));
        fp = next_fp;
    }
}

static long idx = 0;
// 为了直观对比效果，本函数会将 函数名 和 指令的字节偏移量 进行打印
void dumpAddress(const void *p) {
    char *(*demangle)(char const *) = dlsym(RTLD_DEFAULT, "demangle");
    Dl_info info;
    if (dladdr(p, &info)) {
        char *demangleName = demangle(info.dli_sname);
        if (demangleName && strlen(demangleName) > 0) {
            printf("%ld 0x%016lx  %s + %ld \n", idx, (unsigned long)p, demangleName, p - info.dli_saddr);
        } else {
            printf("%ld 0x%016lx  %s + %ld \n", idx, (unsigned long)p, info.dli_sname , p - info.dli_saddr);
        }
    } else {
        printf("非法地址");
    }
    ++idx;
}

@end
