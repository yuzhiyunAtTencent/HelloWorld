//
//  LearnAVFundationViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/1/29.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "YUNPlayOnlineAudioViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoViewController.h"

#define MP3_URL @"http://techslides.com/demos/samples/sample.mp3" //文件来源于 http://techslides.com/sample-files-for-development

@interface YUNPlayOnlineAudioViewController ()

@property(nonatomic, strong) UIButton *startPlayBtn;
@property(nonatomic, strong) UIProgressView *musicProgressView;

@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerItem * songItem;

@end

@implementation YUNPlayOnlineAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.startPlayBtn = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, [UIScreen mainScreen].bounds.size.height - 200,[UIScreen mainScreen].bounds.size.width - 200, 48)];
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 24;
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        [btn setTitle:@"播放在线音乐" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startPlay:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:self.startPlayBtn];
    
    self.musicProgressView = ({
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 250,[UIScreen mainScreen].bounds.size.width - 48, 20)];
        progressView.backgroundColor = [UIColor whiteColor];
        progressView;
    });
    [self.view addSubview:self.musicProgressView];
    
    [self setMusicInfo];
    [self _addObserver];
}

-(void)setMusicInfo {
    NSURL * url  = [NSURL URLWithString:MP3_URL];
    AVPlayerItem * songItem = [[AVPlayerItem alloc] initWithURL:url];
    self.songItem = songItem;
    self.player = [[AVPlayer alloc] initWithPlayerItem:songItem];
    
    //    @weakify(self); 我目前没有添加对应的库，正式工程中一定要加上@weakify(self);
    id observer = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(10.0, 10.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //        @strongify(self);
        CGFloat currentTime = CMTimeGetSeconds(time);
        self.musicProgressView.progress = currentTime / CMTimeGetSeconds(self.player.currentItem.duration);
        [self updateNowPlayingInfoCenter];
    }];
    
    //告诉系统，我们要接受远程控制事件（如果这里不设置，即使设置了MPNowPlayingInfoCenter，控制中心也不会显示歌曲信息）
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)_addObserver {
    //通过Observer方式监听播放状态
    [self.songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    //通过Observer方式监听数据缓冲状态
    [self.songItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];



    //通过Notification监听播放是否结束
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:songItem]
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {

//在KVO方法中获取其status的改变
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                NSLog(@"未知状态，此时不能播放");
                break;
            case AVPlayerStatusReadyToPlay:
//                self.status = StatusReadyToPlay;
                NSLog(@"已经就绪，可以播放");
                break;
            case AVPlayerStatusFailed:
                NSLog(@"加载失败，网络或者解析出问题");
                break;
            default:
                break;
        }
    } else if([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray * array = self.songItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue]; //缓冲的时间范围
        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration); //缓冲总长度
        NSLog(@"缓冲%.2f",totalBuffer);
    }
}

-(void)startPlay:(id)sender {
    [self.player play];
}

//设置控制中心的歌曲信息
-(void)updateNowPlayingInfoCenter {
    NSDictionary *info = @{MPMediaItemPropertyArtist:@"俞志云",
                           MPMediaItemPropertyAlbumTitle:@"一首歌的名字",
                           MPMediaItemPropertyPlaybackDuration:@(CMTimeGetSeconds(self.player.currentItem.duration)),
                           MPNowPlayingInfoPropertyElapsedPlaybackTime:@(CMTimeGetSeconds(self.player.currentTime))
                           };
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:info];
}

//响应远程音乐播放控制消息
- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                NSLog(@"暂停播放");
                break;
            case UIEventSubtypeRemoteControlPause:
                NSLog(@"继续播放");
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"下一曲");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"上一曲");
                break;
            default:
                break;
        }
    }
}

@end

