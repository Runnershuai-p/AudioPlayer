//
//  APIServiceUrl.m
//  TodayCook
//
//  Created by shuai pan on 2017/11/23.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "APIServiceUrl.h"

@implementation APIServiceUrl

+ (NSString *)apiAllAudios{
    return [NSString stringWithFormat:@"audio_api?service=%@",@"allAudios"];
}

@end
