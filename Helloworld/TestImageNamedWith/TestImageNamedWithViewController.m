//
//  TestImageNamedWithViewController.m
//  Helloworld
//
//  Created by yuzhiyun on 2021/5/28.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "TestImageNamedWithViewController.h"

@interface TestImageNamedWithViewController ()
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIImageView *image4;
@property (nonatomic, strong) UIImageView *image5;
@property (nonatomic, strong) UIImageView *image6;
@property (nonatomic, strong) UIImageView *image7;
@end

@implementation TestImageNamedWithViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    
    
//    NSLog(@"[TimeAnalysis ] %.2f",(CACurrentMediaTime()- t1)*1000);
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(addViewAndSetImage)]];
}

- (void)_click {
    CFTimeInterval t1 = CACurrentMediaTime();
    
    if (@available(iOS 13.0, *)) {
        self.image1.image = [UIImage imageNamed:@"bottom_menu_origin_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        self.image2.image = [UIImage imageNamed:@"bottom_menu_music" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        self.image3.image = [UIImage imageNamed:@"bottom_menu_music_far" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        self.image4.image = [UIImage imageNamed:@"bottom_menu_extra_music" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        self.image5.image = [UIImage imageNamed:@"bottom_menu_sound_effect" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        self.image6.image = [UIImage imageNamed:@"bottom_menu_tts_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        self.image7.image = [UIImage imageNamed:@"bottom_menu_record_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
    }
    NSLog(@"[TimeAnalysis ] %.2f",(CACurrentMediaTime()- t1)*1000);
}

- (void)addViewAndSetImage {
    CFTimeInterval t1 = CACurrentMediaTime();
    self.image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 20, 20)];
    [self.view addSubview:self.image1];
    
    self.image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 220, 20, 20)];
    [self.view addSubview:self.image2];
    
    self.image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240, 20, 20)];
    [self.view addSubview:self.image3];
    
    self.image4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 260, 20, 20)];
    [self.view addSubview:self.image4];
    
    self.image5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 280, 20, 20)];
    [self.view addSubview:self.image5];
    
    self.image6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 20, 20)];
    [self.view addSubview:self.image6];
    
    self.image7 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 320, 20, 20)];
    [self.view addSubview:self.image7];
    NSLog(@"[TimeAnalysis view creat] %.2f",(CACurrentMediaTime()- t1)*1000);
    if (@available(iOS 13.0, *)) {
        CFTimeInterval t2 = CACurrentMediaTime();
//        self.image1.image = [UIImage imageNamed:@"bottom_menu_origin_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
//        self.image2.image = [UIImage imageNamed:@"bottom_menu_music" inBundle:[NSBundle mainBundle] withConfiguration:nil];
//        self.image3.image = [UIImage imageNamed:@"bottom_menu_music_far" inBundle:[NSBundle mainBundle] withConfiguration:nil];
//        self.image4.image = [UIImage imageNamed:@"bottom_menu_extra_music" inBundle:[NSBundle mainBundle] withConfiguration:nil];
//        self.image5.image = [UIImage imageNamed:@"bottom_menu_sound_effect" inBundle:[NSBundle mainBundle] withConfiguration:nil];
//        self.image6.image = [UIImage imageNamed:@"bottom_menu_tts_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
//        self.image7.image = [UIImage imageNamed:@"bottom_menu_record_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        
        UIImage *image1 = [UIImage imageNamed:@"bottom_menu_origin_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        UIImage *image2 = [UIImage imageNamed:@"bottom_menu_music" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        UIImage *image3 = [UIImage imageNamed:@"bottom_menu_music_far" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        UIImage *image4 = [UIImage imageNamed:@"bottom_menu_extra_music" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        UIImage *image5 = [UIImage imageNamed:@"bottom_menu_sound_effect" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        UIImage *image6 = [UIImage imageNamed:@"bottom_menu_tts_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        UIImage *image7 = [UIImage imageNamed:@"bottom_menu_record_audio" inBundle:[NSBundle mainBundle] withConfiguration:nil];
        NSLog(@"[TimeAnalysis ] %.2f",(CACurrentMediaTime()- t2)*1000);
        
    }
}
@end
