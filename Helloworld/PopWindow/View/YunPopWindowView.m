//
//  YunPopWindowView.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/2/3.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "YunPopWindowView.h"

@interface YunPopWindowView ()

@property(nonatomic, strong) UIButton *cancelBackground;    // 覆盖在整个屏幕的背景
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation YunPopWindowView

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.cancelBackground = ({
            UIButton *btn = [[UIButton alloc] initWithFrame:self.bounds];
            btn = [[UIButton alloc] initWithFrame: [UIScreen mainScreen].bounds];
            btn.backgroundColor = [UIColor lightGrayColor];
            btn.alpha = 0.5f;
            [btn addTarget:self action:@selector(p_cancel) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        
        self.contentView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 300, self.bounds.size.width - 20, 200)];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 2.f;
            view.backgroundColor = [UIColor whiteColor];
            view.layer.borderColor = [UIColor blackColor].CGColor;
            view;
        });
        [self addSubview:self.contentView];
        
        self.titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.bounds.size.width - 40, 30)];
            label.text = @"这是一个弹窗";
            label;
        });
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark Public
- (void)showPopWindowView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController.view addSubview:self.cancelBackground];
    [rootViewController.view addSubview:self.contentView];
}

#pragma mark Private
- (void)p_cancel {
    [self.cancelBackground removeFromSuperview];
    [self.contentView removeFromSuperview];
}

@end
