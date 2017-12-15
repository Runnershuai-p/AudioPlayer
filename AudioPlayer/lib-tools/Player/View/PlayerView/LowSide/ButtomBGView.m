//
//  ButtomBGView.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/10.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//





#import "ButtomBGView.h"
#import "NSString+time.h"
#define NORMAL_ITEMS @{@"play":@"MusicPlayer_pause",@"next":@"MusicPlayer_next",@"last":@"MusicPlayer_last",@"download":@"MusicPlayer_down",@"list":@"songs_list"}
#define SELECTED_ITEMS @{@"play":@"MusicPlayer_play",@"next":@"MusicPlayer_next",@"last":@"MusicPlayer_last",@"download":@"MusicPlayer_down",@"list":@"songs_list"}


@interface ButtomBGView ()
@property (nonatomic ,strong)NSMutableArray *items;

@property (nonatomic ,strong)UILabel *leftTime;
@property (nonatomic ,strong)UILabel *rightTime;

@property (nonatomic ,copy)void(^itemSelectBlock)(NSInteger);

@end
@implementation ButtomBGView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bsl_controls];
    }
    return self;
}
- (void)bsl_controls{
    
    for (int i = 0; i<self.items.count; i++) {
        ItemButton *item = (ItemButton*)self.items[i];
        item.tag = i;
        [self addSubview:item];
    }
    [self addSubview:self.slider];
    [self addSubview:self.leftTime];
    [self addSubview:self.rightTime];
    [self addSubview:self.circularItem];
    
    
    
}

- (void)setTotalTime:(float )totalTime{
    _totalTime = totalTime;
    self.rightTime.text = [NSString convertTime:_totalTime];
}
- (void)setCurrentTime:(float)currentTime{
    _currentTime = currentTime;
    self.leftTime.text = [NSString convertTime:_currentTime];
}

- (void)setProgress:(float)progress{
    _progress = progress;
    self.slider.value = _progress;
}
- (void)sliderValueChanged:(UISlider *)slider{
    if (self.dragPlayerProgress) {
        self.dragPlayerProgress(slider.value*self.totalTime);
    }
}




- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    
    self.slider.frame = CGRectMake(65, 10, self_w-130, 25);
    CGFloat slider_offsetx = 65;
    self.leftTime.bounds = CGRectMake(0, 0, slider_offsetx, 21);
    self.leftTime.center = CGPointMake(slider_offsetx/2, CGRectGetMidY(self.slider.frame));
    
    self.rightTime.bounds = CGRectMake(0, 0, slider_offsetx, 21);
    self.rightTime.center = CGPointMake(slider_offsetx/2+CGRectGetMaxX(self.slider.frame), CGRectGetMidY(self.slider.frame));
    
    
    self.playItem.bounds = CGRectMake(0, 0, 45, 45);
    self.playItem.center = CGPointMake(self_w/2, self_h/2);
    
    self.lastItem.bounds = CGRectMake(0, 0, 30, 30);
    self.lastItem.center = CGPointMake(CGRectGetMidX(self.playItem.frame)*3/5, CGRectGetMidY(self.playItem.frame));
    
    self.nextItem.bounds = CGRectMake(0, 0, 30, 30);
    self.nextItem.center = CGPointMake(CGRectGetMidX(self.playItem.frame)*7/5, CGRectGetMidY(self.playItem.frame));
    
    CGFloat listItem_x = (self_w - CGRectGetMidX(self.nextItem.frame))*2/3+CGRectGetMidX(self.nextItem.frame);
    
    self.downloadItem.bounds = CGRectMake(0, 0, 25, 25);
    self.downloadItem.center = CGPointMake(listItem_x, CGRectGetMidY(self.nextItem.frame)+0.3*self_h);
    
    self.listItem.bounds = CGRectMake(0, 0, 20, 20);
    self.listItem.center = CGPointMake(listItem_x, CGRectGetMidY(self.nextItem.frame));
    
    self.circularItem.bounds = CGRectMake(0, 0, 20, 20);
    CGFloat circularItem_x = CGRectGetMidX(self.lastItem.frame)/2;
    self.circularItem.center = CGPointMake(circularItem_x, CGRectGetMidY(self.lastItem.frame));

}
- (NSDictionary *)itemButtomsDictionary{

    NSMutableDictionary *itemsDict = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [NORMAL_ITEMS enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *imageString = obj;
        ItemButton *item = [[ItemButton alloc]initWithFrame:CGRectZero backgroundImage:imageString selectImage:SELECTED_ITEMS[key]];
        [itemsDict setObject:item forKey:key];
    }];
    return itemsDict;
}




- (NSMutableArray*)items{
    if (!_items) {
        _items = [NSMutableArray arrayWithCapacity:2];
        NSDictionary *dict = [self itemButtomsDictionary];
        for (NSString *key in dict.allKeys) {
            if ([key hasPrefix:@"play"]) {
                self.playItem = dict[key];
            }
            else if ([key hasPrefix:@"next"]){
                self.nextItem = dict[key];
            }
            else if ([key hasPrefix:@"last"]){
                self.lastItem = dict[key];
            }
            else if ([key hasPrefix:@"download"]){
                self.downloadItem = dict[key];
            }
            else if ([key hasPrefix:@"list"]){
                self.listItem = dict[key];
            }
            [_items addObject:dict[key]];
        }
    }
    return _items;
}

- (CircularItem*)circularItem{
    if (!_circularItem) {
        _circularItem = [[CircularItem alloc]initWithFrame:CGRectZero circularImages:@[@"MusicPlayer_ inturn",@"MusicPlayer_random",@"MusicPlayer_single"]];
    }
    return _circularItem;
}

- (UISlider*)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]initWithFrame:CGRectZero];
        [_slider setThumbImage:[UIImage imageNamed:@"Slider_btn"] forState:UIControlStateNormal] ;
        [_slider setMinimumTrackTintColor:[UIColor whiteColor]];
        [_slider setMaximumTrackTintColor:[UIColor whiteColor]];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
//        _slider.value = 0.2f;
    }
    return _slider;
}
- (UILabel *)leftTime{
    if (!_leftTime) {
        _leftTime  = [[UILabel alloc]initWithFrame:CGRectZero];
        _leftTime.textColor = [UIColor whiteColor];
        _leftTime.font = [UIFont systemFontOfSize:12];
        _leftTime.textAlignment = NSTextAlignmentCenter;
//        _leftTime.backgroundColor = [UIColor redColor];
        _leftTime.text = @"00:00";//14:99

    }
    return _leftTime;
}
- (UILabel *)rightTime{
    if (!_rightTime) {
        _rightTime  = [[UILabel alloc]initWithFrame:CGRectZero];
        _rightTime.textColor = [UIColor whiteColor];
        _rightTime.font = [UIFont systemFontOfSize:12];
        _rightTime.textAlignment = NSTextAlignmentCenter;
        _rightTime.text = @"00:00";//24:99

        
    }
    return _rightTime;
}


- (void)dealloc{
    NSLog(@"ButtomBGVew dealloc ");
    
}

@end
