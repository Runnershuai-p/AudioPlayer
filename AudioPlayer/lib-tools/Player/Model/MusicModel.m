//
//  MusicModel.m
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/1.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self) {
        _music_id = [dict objectForKey:@"_music_id"];
        _song_name = [dict objectForKey:@"song_name"];
        _song_url = [dict objectForKey:@"song_url"];
        _lrcName = [dict objectForKey:@"lrcName"];
        _singer = [dict objectForKey:@"singer"];
        _album_icon =[dict objectForKey:@"album_icon"];
    }
    return self;
}
@end

