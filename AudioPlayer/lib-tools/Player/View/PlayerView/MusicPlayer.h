//
//  MusicPlayer.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/7.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "MusicPlayerView.h"
#import "MusicOpeartion.h"


@class MusicModel;

@interface MusicPlayer : MusicPlayerView

@property (nonatomic ,strong)NSArray *songsArr;



- (void)dismissPlayer:(void(^)(BOOL dissmiss))dismissBlock;
@end
