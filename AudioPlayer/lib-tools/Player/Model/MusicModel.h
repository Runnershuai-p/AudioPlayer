//
//  MusicModel.h
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/1.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject
@property (nonatomic, assign) NSInteger musicIndex;


@property (nonatomic, strong) NSNumber *music_id; // 歌曲id
@property (nonatomic, strong) NSString *song_name; // 歌曲名
@property (nonatomic, strong) NSString *song_url; // 歌曲地址
@property (nonatomic, strong) NSString *lrcName;
@property (nonatomic, strong) NSString *singer; // 歌手
@property (nonatomic, strong) NSString *album_icon;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
