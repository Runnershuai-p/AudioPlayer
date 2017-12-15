//
//  TopBGView.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/3.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "TopBGView.h"
#import "RotatingView.h"
#import "TopHeaderView.h"


@interface TopBGView()



@property (nonatomic ,strong)RotatingView *rotatingView;
@property (nonatomic ,strong)TopHeaderView *headerView;

@end
@implementation TopBGView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bsl_controls];
    }
    return self;
}
- (void)bsl_controls{
    self.startPlay = NO;
    [self addSubview:self.headerView];
    [self addSubview:self.rotatingView];
    [self bringSubviewToFront:self.headerView];
    
}
- (void)currentBackgroundImage:(MusicModel*)model completed:(void(^)(UIImage *rotatingImage))completion{
    [self.rotatingView setRotatingView:model completed:^(UIImage *rotatingImage) {
        completion(rotatingImage);
    }];
}

- (void)setStartPlay:(BOOL)startPlay{
    _startPlay = startPlay;
    self.headerView.startPlay = _startPlay;
    _startPlay? [self.rotatingView resumeLayer]:[self.rotatingView pauseLayer];
}
- (void)layoutSubviews{
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    self.headerView.frame = CGRectMake(0, 0, self_w,HEADER_H);
    
    CGFloat w = self_h-HEADER_H<self_w/2? self_h-HEADER_H:self_w/2;
    self.rotatingView.frame = CGRectMake((self_w- w*4/3)/2, CGRectGetMaxY(self.headerView.frame)+20, w*4/3, w*4/3);
}


- (TopHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[TopHeaderView alloc]initWithFrame:CGRectZero];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

- (RotatingView *)rotatingView{
    if (!_rotatingView) {
        _rotatingView = [[RotatingView alloc]initWithFrame:CGRectZero];
//        _rotatingView.backgroundColor = [UIColor clearColor];
    }
    return _rotatingView;
}





- (void)dealloc{
    
    NSLog(@"TopBgView dealloc");
}













@end
