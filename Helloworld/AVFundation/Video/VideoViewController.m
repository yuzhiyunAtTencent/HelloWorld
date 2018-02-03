//
//  VideoViewController.m
//  LearnAVPlayer
//
//  Created by zhiyunyu on 2018/1/31.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>

#define VIDEO_URL @"http://techslides.com/demos/samples/sample.mp4" //文件来源于 http://techslides.com/sample-files-for-development

@interface VideoViewController ()

@property(nonatomic, strong) UIButton *startPlayBtn;
@property(nonatomic, strong) UIProgressView *progressView;

@property(nonatomic, strong) AVPlayer *avPlayer;
@property(nonatomic, strong) AVPlayerItem *playerItem;
@property(nonatomic, strong) AVPlayerLayer *avLayer;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setVideoInfo];
    
    self.avLayer.frame = CGRectMake(0, 100, self.view.bounds.size.width, 200);
    self.avLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.avLayer.videoGravity = AVLayerVideoGravityResize;//拉伸占满frame
    [self.view.layer addSublayer:self.avLayer];
    
    self.progressView = ({
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 300 - 10,self.view.bounds.size.width, 10)];
        progressView.backgroundColor = [UIColor whiteColor];
        progressView;
    });
    [self.view addSubview:self.progressView];
    
    self.startPlayBtn = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, [UIScreen mainScreen].bounds.size.height - 200,[UIScreen mainScreen].bounds.size.width - 200, 48)];
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 24;
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        [btn setTitle:@"播放在线视频" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startPlay:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:self.startPlayBtn];
}

- (void)setVideoInfo {
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:VIDEO_URL]];
    self.avPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.avLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    
    [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(10.0, 10.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat currentTime = CMTimeGetSeconds(time);
        self.progressView.progress = currentTime / CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    }];
}

-(void)startPlay:(id)sender {
    [self.avPlayer play];
}

@end
