//
//  MusicOpeariton.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/9.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  AudioPlayerMode 播放模式
 */
typedef NS_ENUM(NSInteger, AudioPlayerReadyStatus) {
    /**
     *  播放准备成功
     */
    AudioPlayerReadySuccess,
    /**
     *  播放准备失败
     */
    AudioPlayerReadyFailed,
};

/**
 *  AudioPlayerMode 播放模式
 */
typedef NS_ENUM(NSInteger, AudioPlayerMode) {
    /**
     *  顺序播放
     */
    AudioPlayerModeOrderPlay,
    /**
     *  随机播放
     */
    AudioPlayerModeRandomPlay,
    /**
     *  单曲循环
     */
    AudioPlayerModeSinglePlay,
};

@interface MusicOpeartion : NSObject

@property (nonatomic, assign)AudioPlayerReadyStatus playerReadyStatus;

@property (nonatomic, assign)AudioPlayerMode playerMode;
/**
 * 取得视频加载进度
 */
@property (nonatomic, copy)void (^musicLoadedTimeBlock)(CGFloat);

/**
 * 定位到当前播放时间(回调，刷新时间栏)
 */
@property (nonatomic, copy)void (^locateMusicPlayingTimeBlock)(CGFloat,CGFloat);

/**
 * 播放结束回调
 */
@property (nonatomic ,copy)void (^musicPlayEndBlock)(NSInteger playMode);


- (void)addPlayerWithMusicModel:(NSString *)urlString success:(void (^)(CGFloat totalTime))successBlock failed:(void(^)(void))failedBlock;


+ (instancetype)defaultOpeartion;




- (void)startPlay;

- (void)stopPlay;


- (void)seekToTimeWithSeconds:(float)seconds;
@end
