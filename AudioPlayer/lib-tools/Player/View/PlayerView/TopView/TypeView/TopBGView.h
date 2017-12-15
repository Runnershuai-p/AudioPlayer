//
//  TopBGView.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/3.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEADER_H 60.0f

@class MusicModel;

@interface TopBGView : UIView
@property (nonatomic ,assign)BOOL startPlay;


- (void)currentBackgroundImage:(MusicModel*)model completed:(void(^)(UIImage *rotatingImage))completion;
@end
