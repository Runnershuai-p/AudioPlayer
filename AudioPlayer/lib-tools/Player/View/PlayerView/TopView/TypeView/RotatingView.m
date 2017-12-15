
//
//  RotatingView.m
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/12.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "RotatingView.h"
#import "MusicModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define RING_W 10.0f //边界半透明宽度
@interface RotatingView ()


@end

@implementation RotatingView


#pragma mark Public Method

- (void)setRotatingView:(MusicModel*)model completed:(void(^)(UIImage *rotatingImage))completion{

    [_albumImage sd_setImageWithURL:[NSURL URLWithString:model.album_icon] placeholderImage:[UIImage imageNamed:@"rotating_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image!=nil? completion(image):[UIImage imageNamed:@"music_bg_default"];
    }];
    [self imageViewAnimation:self.albumImage];
    [self pauseLayer];
}




// 停止
-(void)pauseLayer{
    CFTimeInterval pausedTime = [self.albumImage.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.albumImage.layer.speed = 0.0;
    self.albumImage.layer.timeOffset = pausedTime;
}

// 恢复
-(void)resumeLayer{
    CFTimeInterval pausedTime = self.albumImage.layer.timeOffset;
    self.albumImage.layer.speed = 1.0;
    self.albumImage.layer.timeOffset = 0.0;
    self.albumImage.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.albumImage.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.albumImage.layer.beginTime = timeSincePause;
}

- (void)removeAnimation{
    [self.albumImage.layer removeAllAnimations];
}



#pragma mark Private Method

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self addSubview:self.albumImage];

    }
    return self;
}
// 添加动画
- (void)imageViewAnimation:(UIImageView *)imageView{
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
    monkeyAnimation.duration = 20.0f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO; //No Remove
    monkeyAnimation.fillMode = kCAFillModeForwards;
    monkeyAnimation.repeatCount = FLT_MAX;
    [imageView.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    self.clipsToBounds  = YES;
    self.layer.cornerRadius  = self_w/2.f;
    
    self.albumImage.frame = CGRectMake(RING_W, RING_W, self_w - RING_W*2, self_w - RING_W*2);
    _albumImage.clipsToBounds  = YES;
    _albumImage.layer.cornerRadius = CGRectGetWidth(_albumImage.frame)/2.f;

    
}

- (UIImageView*)albumImage{
    if (!_albumImage) {
        _albumImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _albumImage.image = [UIImage imageNamed:@"rotating_default"];
    }
    return _albumImage;
}


- (void)dealloc{
    
    NSLog(@"RotatingView dealloc");
}


@end
