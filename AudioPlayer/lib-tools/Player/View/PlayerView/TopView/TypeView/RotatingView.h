//
//  RotatingView.h
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/12.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModel;
@interface RotatingView : UIView

//@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *albumImage;



- (void)setRotatingView:(MusicModel*)model completed:(void(^)(UIImage *rotatingImage))completion;
// 停止
-(void)pauseLayer;
// 恢复
-(void)resumeLayer;
// 移除动画
- (void)removeAnimation;

@end
