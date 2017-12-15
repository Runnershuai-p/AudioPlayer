//
//  TitleView.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/7.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView : UIView

@property (nonatomic ,copy)NSString *song;
@property (nonatomic ,copy)NSString *songer;

@property (nonatomic ,copy)void (^dismissPlayer)(BOOL dismiss);
@end
