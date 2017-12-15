//
//  ButtomBGView.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/10.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemButton.h"
#import "CircularItem.h"


@interface ButtomBGView : UIView
@property (nonatomic ,strong)UISlider *slider;
@property (nonatomic ,strong)ItemButton *playItem;
@property (nonatomic ,strong)ItemButton *lastItem;
@property (nonatomic ,strong)ItemButton *nextItem;
@property (nonatomic ,strong)ItemButton *playTypeItem;
@property (nonatomic ,strong)ItemButton *listItem;
@property (nonatomic ,strong)ItemButton *downloadItem;
@property (nonatomic ,strong)CircularItem *circularItem;

@property (nonatomic ,assign)float currentTime;
@property (nonatomic ,assign)float totalTime;
@property (nonatomic ,assign)float progress;
@property (nonatomic ,copy)void((^dragPlayerProgress)(float dragValue));

@end
