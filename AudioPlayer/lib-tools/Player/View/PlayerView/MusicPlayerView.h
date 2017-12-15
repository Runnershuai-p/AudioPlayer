//
//  MusicBGView.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/9.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TitleView.h"
#import "ButtomBGView.h"

#import "ListTable.h"
#import "TypeView.h"

typedef enum : NSUInteger {
    PlayActionTypePlay,
    PlayActionTypeLast,
    PlayActionTypeNext,
    PlayActionTypeList,
    PlayActionTypeDownload,
    PlayActionTypeCircular
} PlayActionType;


@class MusicModel;
@interface MusicPlayerView : UIView


@property (nonatomic ,strong)UIImageView *bgImageView;
@property (nonatomic ,strong)TitleView *titleView;
@property (nonatomic ,strong)ButtomBGView *buttomView;
@property (nonatomic ,strong)ListTable *listTable;

@property (nonatomic ,strong)TypeView *typeView;




- (void)musicPlayerActionEvents;



@end
