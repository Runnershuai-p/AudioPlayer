//
//  NSString+time.m
//  MusicPlayerDemo
//
//  Created by shuai pan on 2017/3/3.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//


#import "NSString+time.h"

@implementation NSString (time)

+ (NSString *)convertTime:(CGFloat)second{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    return [formatter stringFromDate:date];
}

@end
