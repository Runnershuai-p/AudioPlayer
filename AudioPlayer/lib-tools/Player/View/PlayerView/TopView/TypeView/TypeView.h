//
//  TypeView.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/8.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TopBGView.h"
#import "LyricBGView.h"


@interface TypeView : UIView

@property (nonatomic ,strong)LyricBGView *lyricView;
@property (nonatomic ,strong)TopBGView *topView;
@end
