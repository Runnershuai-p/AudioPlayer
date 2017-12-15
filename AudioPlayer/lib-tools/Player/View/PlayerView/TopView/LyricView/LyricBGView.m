//
//  LyricBGView.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/10.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "LyricBGView.h"

@interface LyricBGView  ()



@end
@implementation LyricBGView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self lyricBGViewControls];
    }
    return self;

}
- (void)lyricBGViewControls{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
}

- (void)drawRect:(CGRect)rect{
    CGSize size = [@"暂无歌词" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:28]}];
    
    [@"暂无歌词" drawAtPoint:CGPointMake(rect.size.width/2-size.width/2, rect.size.height/2-size.height/2) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:28],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
}

- (void)dealloc{
    NSLog(@"LyricBGView dealloc ");

}
@end
