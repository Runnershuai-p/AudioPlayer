//
//  NSString+time.h
//  MusicPlayerDemo
//
//  Created by shuai pan on 2017/3/3.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (time)

/**
 * 时间转换
 */
+ (NSString *)convertTime:(CGFloat)second;

@end
