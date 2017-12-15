//
//  TypeView.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/8.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "TypeView.h"


@interface TypeView  ()


@property (nonatomic ,assign)BOOL showLyric;

@end
@implementation TypeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(typeViewClickAction)];
        [self addGestureRecognizer:tapGesture];
        [self typeViewControls];
    }
    return self;
}
- (void)typeViewControls{
    self.showLyric = NO;
    [self addSubview:self.topView];
    [self addSubview:self.lyricView];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);

    self.topView.frame = CGRectMake(0, 0, self_w, self_h);
    
    self.lyricView.frame = CGRectMake(0, 20, self_w, self_h-20);
    
    
}

- (void)typeViewClickAction{
    self.showLyric = !self.showLyric;
}
- (void)setShowLyric:(BOOL)showLyric{
    _showLyric = showLyric;
    
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        if (_showLyric) {
            self.lyricView.alpha = 1;
            self.topView.alpha = 0.0;
        }
        else{
            self.lyricView.alpha = 0.0;
            self.topView.alpha = 1;
        }
        self.lyricView.hidden = !_showLyric;
        self.topView.hidden = _showLyric;
    } completion:nil];
    
    
    
}
- (TopBGView *)topView{
    if (!_topView) {
        _topView = [[TopBGView alloc]initWithFrame:CGRectZero];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (LyricBGView *)lyricView{
    if (!_lyricView) {
        _lyricView = [[LyricBGView alloc]initWithFrame:CGRectZero];
    }
    return _lyricView;
}
- (void)dealloc{
    
    NSLog(@"TypeView dealloc");
}



@end
