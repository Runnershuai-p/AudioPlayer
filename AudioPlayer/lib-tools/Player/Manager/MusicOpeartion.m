//
//  MusicOpeariton.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/9.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "MusicOpeartion.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "NSString+URL.h"
#import <AFNetworking/AFNetworking.h>
@interface MusicOpeartion (){
    id _playTimeObserver; // 播放进度观察者

}

@property (nonatomic, copy)void (^musicPlayFailed)();

@property (nonatomic, copy)void (^musicPlaySuccessfull)(CGFloat);


@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) id playTimeObserver;


@end

@implementation MusicOpeartion

+ (instancetype)defaultOpeartion{
    static MusicOpeartion *obj ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[MusicOpeartion alloc]init];
    });
    return obj;
}

- (void)addPlayerWithMusicModel:(NSString *)urlString success:(void (^)(CGFloat totalTime))successBlock failed:(void(^)())failedBlock{
    if (self.player) {
        self.player = nil;
        [self musicRemoveObserver];
    }
    urlString =  [urlString URLEncodedString];
    NSURL *url = [NSURL fileURLWithPath:urlString ];
    if ([urlString hasPrefix:@"http"]) {
        url = [NSURL URLWithString:urlString];
    }
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:urlAsset];
    if (self.player.currentItem) {
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    }
    else{
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    }
    self.player.volume = 0.5;
    
    //添加音乐总长度
    self.musicPlaySuccessfull = successBlock;
    self.musicPlayFailed = failedBlock;
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
}
//暂停
- (void)stopPlay{
    [self.player pause];
}
//播放
- (void)startPlay{
    [self.player play];
}
//快进
- (void)seekToTimeWithSeconds:(float)seconds{
    CMTime dragedCMTime = CMTimeMake(seconds, 1);
    [self.playerItem seekToTime:dragedCMTime];
}




#pragma mark - KVO - status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([self.playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            self.playerReadyStatus = AudioPlayerReadySuccess;
            CMTime duration = item.duration;// 获取视频总长度
            CGFloat totalTime = CMTimeGetSeconds(duration);//转换成秒
            if (self.musicPlaySuccessfull) {
                self.musicPlaySuccessfull(totalTime);
            }
            [self monitoringPlayerStatus:self.playerItem];// 监听播放状态
        }else if([self.playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
            self.playerReadyStatus = AudioPlayerReadyFailed;

            if (self.musicPlayFailed) {
                self.musicPlayFailed();
            }
            [self stopPlay];
        }
    }
}
// 实时监听播放状态
- (void)monitoringPlayerStatus:(AVPlayerItem *)item {
    __weak typeof(self) weakSelf = self;
    self.playTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //获取当前时间
        CGFloat currentSeconds = CMTimeGetSeconds(weakSelf.playerItem.currentTime);
        CGFloat totalTime = CMTimeGetSeconds(weakSelf.playerItem.duration);
        
        if (weakSelf.locateMusicPlayingTimeBlock) {
            weakSelf.locateMusicPlayingTimeBlock(currentSeconds,totalTime);
        }
    }];
}

-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    __weak typeof(self) weakSelf = self;
    self.playerItem = [notification object];
    NSInteger playMode = self.playerMode;
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        if (weakSelf.musicPlayEndBlock) {
            weakSelf.musicPlayEndBlock(playMode);
        }
    }];
}






- (void)allowMusicPlayBackground{
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
}


- (void)musicRemoveObserver{
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil ];
}


@end











