//
//  TitleView.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/7.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "TitleView.h"

@interface TitleView  ()



@property (strong, nonatomic) UIButton *dismissButton;


@property (strong, nonatomic) UILabel *songLab;
@property (strong, nonatomic) UILabel *songerLab;
@property (strong, nonatomic) UIView *navigationItem;

@end
@implementation TitleView



- (void)setSong:(NSString *)song{
    _song = song;
    self.songLab.text = _song;
}
- (void)setSonger:(NSString *)songer{
    _songer = songer;
    self.songerLab.text = _songer;
    
}





- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self titleViewControls];
    }
    return self;
}
- (void)titleViewControls{
    [self addSubview:self.navigationItem];
    [self addSubview:self.songerLab];
    [self addSubview:self.songLab];
    [self addSubview:self.dismissButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    self.navigationItem.frame = CGRectMake(0, 0, self_w, self_h);
    self.songLab.frame = CGRectMake(self_w/2-100, 20, 200, 20);
    self.songerLab.frame = CGRectMake(self_w/2-100, CGRectGetMaxY(self.songLab.frame), 200,CGRectGetHeight(self.navigationItem.frame) -CGRectGetMaxY(self.songLab.frame)-5);
    
    self.dismissButton.frame = CGRectMake(self_w-60-5 ,20, 60, self_h-20);
}
- (UILabel *)songerLab{
    if (!_songerLab) {
        _songerLab  = [[UILabel alloc]initWithFrame:CGRectZero];
        _songerLab.textAlignment = NSTextAlignmentCenter;
        _songerLab.textColor = [UIColor whiteColor];
        _songerLab.font = [UIFont systemFontOfSize:12];
    }
    return _songerLab;
}
- (UILabel *)songLab{
    if (!_songLab) {
        _songLab  = [[UILabel alloc]initWithFrame:CGRectZero];
        _songLab.textAlignment = NSTextAlignmentCenter;
        _songLab.textColor = [UIColor whiteColor];
        _songLab.font = [UIFont systemFontOfSize:16];
    }
    return _songLab;
}
- (UIView *)navigationItem{
    if (!_navigationItem) {
        _navigationItem = [[UIView alloc]initWithFrame:CGRectZero];
        _navigationItem.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
    }
    return _navigationItem;
}
- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _dismissButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_dismissButton setTitle:@"退出" forState:UIControlStateNormal];
        [_dismissButton addTarget:self action:@selector(dismissButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}


- (void)dismissButtonClick{
    if (self.dismissPlayer) {
        self.dismissPlayer(YES);
    }
}
- (void)dealloc{
    
    NSLog(@"TitleView dealloc");
}

@end
