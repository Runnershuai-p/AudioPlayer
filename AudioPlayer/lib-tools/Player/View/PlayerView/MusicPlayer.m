//
//  MusicPlayer.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/7.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "MusicPlayer.h"
#import "UIImage+ImageEffects.h"
#import "MusicModel.h"


@interface MusicPlayer ()
@property (nonatomic ,strong)MusicModel *currentPlayModel;

/**
 * music快进
 * fastValue: 快进值
 */
- (void)musicFastForward:(void(^)(float fastValue))fastForwardBlock;
/**
 * 播放器操作事件
 * actionType: 播放类型;
 * selected： 事件触发
 */
- (void)musicPlayerActions:(void(^)(NSInteger actionType,BOOL selected))playActionBlock;

//开始播放
- (void)beginToPlaying;

//暂停播放
- (void)stopToPlaying;

@end
@implementation MusicPlayer


#pragma mark Private Method 

//dismissPlayer
- (void)dismissPlayer:(void(^)(BOOL dissmiss))dismissBlock{
    __weak typeof(self) weakSelf = self;

   [self.titleView setDismissPlayer:^(BOOL dissmiss) {
    
       if (dissmiss) {
           [weakSelf stopToPlaying];
           [weakSelf removeFromSuperview];
       }
       dismissBlock(dissmiss);
   }];
}


- (void)setSongsArr:(NSArray *)songsArr{
    _songsArr = songsArr;
    if (_songsArr.count<1) return;
    for (int i = 0;i<_songsArr.count; i++) {
        if ([_songsArr[i] isKindOfClass:[MusicModel class]] ) {
            MusicModel *model = (MusicModel*)_songsArr[i];
            model.musicIndex = i;
        }
    }
    //默认播放song
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MusicModel *model = _songsArr[0];
        [self startingOpenMusicView:model];
    });
}

#pragma mark Public Method

/**
 * 开始打开音乐视图
 */
- (void)startingOpenMusicView:(MusicModel*)model{
    self.currentPlayModel = model;
    __weak typeof(self) weakSelf = self;
    __weak UIImageView *weakBgImageView = self.bgImageView;
    //专辑图片
    [self.typeView.topView currentBackgroundImage:model completed:^(UIImage *rotatingImage) {
        weakBgImageView.image = [rotatingImage applyDarkEffect];
    }];
    //获取music总长度
    [[MusicOpeartion defaultOpeartion] addPlayerWithMusicModel:model.song_url success:^(CGFloat totalTime) {
        weakSelf.buttomView.totalTime = totalTime;
        weakSelf.titleView.songer = model.singer;
        weakSelf.titleView.song  = model.song_name;
        [weakSelf beginToPlaying];
    } failed:^{
        [weakSelf stopToPlaying];
    }];
    
//    __block NSInteger index = 0;

    //获取music当前播放长度
    [[MusicOpeartion defaultOpeartion] setLocateMusicPlayingTimeBlock:^(CGFloat currentTime, CGFloat  totalTime) {
//        if (currentTime>0) {
//            if (index==0) {
//                [weakSelf beginToPlaying];
//            }
//            index ++;
//        }
        weakSelf.buttomView.progress = currentTime/totalTime;
        weakSelf.buttomView.currentTime = currentTime;
        weakSelf.buttomView.totalTime = totalTime;
    }];
   
}

//开始播放
- (void)beginToPlaying{
    //音乐播放
    [[MusicOpeartion defaultOpeartion] startPlay];
    //动画及UI处理
    self.typeView.topView.startPlay = YES;
    self.buttomView.playItem.itemSelect = YES;
}

//暂停播放
- (void)stopToPlaying{
    
    [[MusicOpeartion defaultOpeartion] stopPlay];
    self.typeView.topView.startPlay = NO;
    self.buttomView.playItem.itemSelect = NO;
    
}

//
- (void)musicPlayerActionEvents{
    [super musicPlayerActionEvents];
    __weak typeof(self) weakSelf = self;
    [self.listTable selectSongSheet:^(MusicModel *model) {
//        歌单选择回调
        [weakSelf startingOpenMusicView:model];
    } closeList:^{
//        关闭歌单
       [weakSelf beginToPlaying];
    }];
    //music播放结束
    [[MusicOpeartion defaultOpeartion] setMusicPlayEndBlock:^(NSInteger playMode) {
        [weakSelf stopToPlaying];
        MusicModel *currentModel = weakSelf.currentPlayModel;
        switch (playMode) {
            case AudioPlayerModeOrderPlay:{
                [weakSelf playNextMusic];
            }
                break;
            case AudioPlayerModeRandomPlay:{
                [weakSelf playRandomMusic];
            }
                break;
            case AudioPlayerModeSinglePlay:{
                [weakSelf startingOpenMusicView:currentModel];
            }
                break;
            default:
                break;
        }
    }];
    
    //music播放类型，循环类型
    [self.buttomView.circularItem  addMenuClickActionMethod:^(NSInteger selectValue) {
//        NSLog(@"播放 value: %@",[NSNumber numberWithInteger:selectValue]);
        [MusicOpeartion defaultOpeartion].playerMode = selectValue;
        
    }];
    //快进
    [self musicFastForward:^(float fastValue) {
        [[MusicOpeartion defaultOpeartion] seekToTimeWithSeconds:fastValue];
    }];
    //播放操作
    [self musicPlayerActions:^(NSInteger actionType, BOOL selected) {
        NSLog(@"actionType: %@",[NSNumber numberWithInteger:actionType]);
        [weakSelf stopToPlaying];
        switch (actionType) {
            case PlayActionTypePlay:{
                if ([MusicOpeartion defaultOpeartion].playerReadyStatus==AudioPlayerReadySuccess) {
                    selected? [weakSelf beginToPlaying]:[weakSelf stopToPlaying];
                }
            }
                break;
            case PlayActionTypeLast:{
                [weakSelf playLastMusic];
            }
                break;
            case PlayActionTypeNext:{
                [weakSelf playNextMusic];
            }
                break;
            case PlayActionTypeList:{
                [weakSelf.listTable updateSongSheet:weakSelf.songsArr];
            }
                break;
            default:
                break;
        }
    }];
}
//***************************************************************************
//快进
- (void)musicFastForward:(void(^)(float fastValue))fastForwardBlock{
    [self.buttomView setDragPlayerProgress:^(float value) {
        fastForwardBlock(value);
    }];
}
//播放器操作事件
- (void)musicPlayerActions:(void(^)(NSInteger actionType,BOOL selected))playActionBlock{
    
    [self.buttomView.playItem addMenuClickActionMethod:^(BOOL isSelect) {
        playActionBlock(PlayActionTypePlay,isSelect);
    }];
    [self.buttomView.lastItem addMenuClickActionMethod:^(BOOL isSelect) {
        playActionBlock(PlayActionTypeLast,isSelect);
    }];
    [self.buttomView.nextItem addMenuClickActionMethod:^(BOOL isSelect) {
        playActionBlock(PlayActionTypeNext,isSelect);
    }];
    [self.buttomView.listItem addMenuClickActionMethod:^(BOOL isSelect) {
        playActionBlock(PlayActionTypeList,isSelect);
    }];
    [self.buttomView.downloadItem addMenuClickActionMethod:^(BOOL isSelect) {
        playActionBlock(PlayActionTypeDownload,isSelect);
    }];
    
}

- (void)playNextMusic{
    NSInteger playIndex = self.currentPlayModel.musicIndex==self.songsArr.count-1? 0:self.currentPlayModel.musicIndex+1;
    MusicModel *nextModel = self.songsArr[playIndex];
    [self startingOpenMusicView:nextModel];
}
- (void)playLastMusic{
    NSInteger playIndex = self.currentPlayModel.musicIndex==0? self.songsArr.count-1:self.currentPlayModel.musicIndex-1;
    MusicModel *nextModel = self.songsArr[playIndex];
    [self startingOpenMusicView:nextModel];
}
- (void)playRandomMusic{
    NSInteger playIndex = arc4random()%self.songsArr.count;
    MusicModel *randomModel = self.songsArr[playIndex];
    [self startingOpenMusicView:randomModel];
}

- (void)dealloc{
    
    NSLog(@"MusicPlyer dealloc ");
    
}

@end
