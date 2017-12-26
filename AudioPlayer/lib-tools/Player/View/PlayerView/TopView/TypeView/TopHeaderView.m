//
//  TOPBGView.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/10.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//


#import "TopHeaderView.h"

#define LINE_h 30.0f
@interface TopHeaderView ()


@property (nonatomic ,strong)BouhieView *bouhieView;
@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,assign)BOOL transforMbouhieImage;



@end
@implementation TopHeaderView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self bsl_controls];
    }
    return self;
}
- (void)bsl_controls{
    [self addSubview:self.lineView];
    [self addSubview:self.bouhieView];
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    self.lineView.frame = CGRectMake(0, 0, self_w, 3);
    self.lineView.center = CGPointMake(self_w/2, self_h/2);
    self.bouhieView.bounds = CGRectMake(0, 0, 150.f, 60);
    self.bouhieView.center = self.lineView.center;
    
}


- (void)setStartPlay:(BOOL)startPlay{
    _startPlay = startPlay;
    [UIView animateWithDuration:0.3 animations:^{
        self.bouhieView.transform = CGAffineTransformMakeRotation(_startPlay? M_PI_2*4/7:0);
    }];
}

- (UIView*)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}


- (BouhieView *)bouhieView{
    if (!_bouhieView) {
        _bouhieView = [[BouhieView alloc]initWithFrame:CGRectZero];
        _bouhieView.backgroundColor = [UIColor clearColor];
    }
    return _bouhieView;
}

- (void)dealloc{
    
    NSLog(@"TopHeaderView dealloc");
}
@end







@interface BouhieView ()


@property (nonatomic ,strong)UIImageView *bouhieImageView;
@property (nonatomic ,strong)UIImageView *nodeImageView;
@end

@implementation BouhieView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bouhieImageView];
        [self addSubview:self.nodeImageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    self.bouhieImageView.frame = CGRectMake(self_w/2, self_h/2, self_w/2, self_h/2);
    self.nodeImageView.bounds = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
    self.nodeImageView.center = CGPointMake(self_w/2, self_h/2);
}
- (UIImageView *)bouhieImageView{
    if (!_bouhieImageView) {
        _bouhieImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _bouhieImageView.image = [UIImage imageNamed:@"sound_bougie"];
    }
    return _bouhieImageView;
}
- (UIImageView *)nodeImageView{
    if (!_nodeImageView) {
        _nodeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _nodeImageView.image = [UIImage imageNamed:@"Slider_btn"];
    }
    return _nodeImageView;
}
- (void)dealloc{
    
    NSLog(@"BouhieView dealloc");
}
@end





















