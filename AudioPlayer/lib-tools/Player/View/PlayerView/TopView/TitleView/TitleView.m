//
//  TitleView.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/7.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//
#define ISIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
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
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
    [self addSubview:self.navigationItem];
    [self.navigationItem addSubview:self.songerLab];
    [self.navigationItem addSubview:self.songLab];
    [self.navigationItem addSubview:self.dismissButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    
    CGFloat navItem_y = ISIPhoneX ? 44.f:20.f;
    self.navigationItem.frame = CGRectMake(0, navItem_y, self_w,self_h - navItem_y);
    CGFloat nav_w = CGRectGetWidth(self.navigationItem.frame);
    CGFloat nav_h = CGRectGetHeight(self.navigationItem.frame);
    self.songLab.frame = CGRectMake(nav_w/2-100, 0.f, 200, nav_h/2);
    self.songerLab.frame = CGRectMake(nav_w/2-100, CGRectGetMaxY(self.songLab.frame), 200,nav_h/2);
    self.dismissButton.frame = CGRectMake(nav_w - 70.f,CGRectGetMinY(self.songLab.frame), 70.f, 30);
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
