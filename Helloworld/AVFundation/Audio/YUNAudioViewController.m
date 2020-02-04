//
//  YUNAudioViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/12/31.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "YUNAudioViewController.h"
#import <AVFoundation/AVAudioPlayer.h>

/* 1、AVAudioPlayer 对象必须作为属性才可以成功播放音乐，比如作为viewController的属性
*    （我之前在viewDidload中创建AVAudioPlayer对象，没有作为一个property,就无法播放，这是内存原因）
* 2、只能播放本地音
*/

@interface YUNAudioViewController () <AVAudioPlayerDelegate>
@property(nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation YUNAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"20191005A02R4R.mp3"]
    
    // 1.获取要音频文件的URL
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:@"20191005A02R4R" withExtension:@".mp3"];
    // 2.创建 AVAudioPlayer 对象
    NSError *outError;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&outError];
    // 3.设置循环播放
    self.audioPlayer.numberOfLoops = 0;
    // 4.设置AVAudioPlayer代理
//    self.audioPlayer.delegate = self;
    // 5.开始播放
    [self.audioPlayer play];
}

@end
