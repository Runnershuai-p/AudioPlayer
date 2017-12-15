//
//  ListTable.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/6.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MusicModel;
@interface ListTable : UIView

@property (nonatomic ,assign)CGFloat listTableHeight;

/**
 * 歌单列表更新
 * songs：歌单参数
 */

- (void)updateSongSheet:(NSArray *)songs;



/**
 * 歌单列表回调
 * selectBlock：歌单选择回调
 * closeListBlock：歌单关闭回调
 */
- (void)selectSongSheet:(void(^)(MusicModel *model))selectBlock closeList:(void(^)())closeListBlock;


@end
