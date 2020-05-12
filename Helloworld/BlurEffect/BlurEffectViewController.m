//
//  BlurEffectViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/5/12.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "BlurEffectViewController.h"
#import "ColorUtil.h"

@interface BlurEffectViewController ()
@property(nonatomic, assign) NSUInteger index;
@property(nonatomic, strong) UIVisualEffectView *dayEffectView;
@property(nonatomic, strong) UIVisualEffectView *nightEffectView;
@end

@implementation BlurEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEX(0xFFFFFF);
    
    self.dayEffectView = ({
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        effectView.frame = CGRectMake(50, 100, 200, 100);
        effectView.backgroundColor = [ColorUtil colorWithHexString:@"#b3e6e6e6"
                                                      defaultColor:[UIColor redColor]];
        effectView;
    });
    self.nightEffectView = ({
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        effectView.frame = CGRectMake(50, 400, 200, 100);
        effectView.backgroundColor = [ColorUtil colorWithHexString:@"#b33d3d3d"
                                                      defaultColor:[UIColor redColor]];
        effectView;
    });
    
    [self.view addSubview:self.dayEffectView];
    [self.view addSubview:self.nightEffectView];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tapView)]];
}

- (void)tapView {
    //    #FFFFFF     #1F1F1F
    self.index += 1;
    if (self.index % 2 == 0) {
        self.view.backgroundColor = [ColorUtil colorWithHexString:@"#FFFFFF"
                                                     defaultColor:[UIColor redColor]];
    } else {
        self.view.backgroundColor = [ColorUtil colorWithHexString:@"#1F1F1F"
                                                     defaultColor:[UIColor redColor]];
    }
}

@end
