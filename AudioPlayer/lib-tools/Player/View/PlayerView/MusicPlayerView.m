//
//  MusicBGView.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/9.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "MusicPlayerView.h"


#define BUTTOM_H 150.f
//@interface MusicPlayerView  ()
//
//
//@end
@implementation MusicPlayerView


#pragma  mark Public Method

- (void)musicPlayerViewControls{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.titleView];
    [self addSubview:self.buttomView];
    [self addSubview:self.typeView];
    [self addSubview:self.listTable];
}



#pragma  mark Private Method
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self musicPlayerViewControls];
        [self musicPlayerActionEvents];
    }
    return self;
}
- (void)musicPlayerActionEvents{
   // Action Events deal with
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    self.bgImageView.frame = self.bounds;
    self.titleView.frame = CGRectMake(0, 0, self_w, 64);
    self.buttomView.frame = CGRectMake(0, self_h-BUTTOM_H, self_w, BUTTOM_H);
    self.typeView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), self_w, CGRectGetMinY(self.buttomView.frame)-CGRectGetMaxY(self.titleView.frame));
    
    CGFloat showListTable_y = CGRectGetMidY(self.typeView.frame);
    self.listTable.listTableHeight = self_h-showListTable_y;
}



- (TypeView *)typeView{
    if (!_typeView) {
        _typeView = [[TypeView alloc]initWithFrame:CGRectZero];
    }
    return _typeView;
}

- (TitleView *)titleView{
    if (!_titleView) {
        _titleView = [[TitleView alloc]initWithFrame:CGRectZero];
    }
    return _titleView;
}


- (ButtomBGView *)buttomView{
    if (!_buttomView) {
        _buttomView = [[ButtomBGView alloc]initWithFrame:CGRectZero];
    }
    return _buttomView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _bgImageView.image = [UIImage imageNamed:@"music_bg_default"];
    }
    return _bgImageView;
}

- (ListTable *)listTable{
    if (!_listTable) {
        _listTable = [[ListTable alloc]initWithFrame:CGRectZero];
        _listTable.clipsToBounds = YES;
        _listTable.layer.cornerRadius = 5;
    }
    return _listTable;
}
- (void)dealloc{
    NSLog(@"MusicPlayer dealloc ");
    
}
@end
