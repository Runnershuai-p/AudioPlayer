//
//  ClientRequestManger.h
//  Chamleon-newTemplate
//
//  Created by Foreveross BSL on 16/8/8.
//  Copyright © 2016年 Foreveross BSL. All rights reserved.//

//

#import <AFNetworking/AFNetworking.h>
#import "APIServiceUrl.h"


typedef NS_ENUM(NSUInteger, ClientRequestCacheStatus){
    ClientRequestCacheThenLoad = 0,// 有缓存就先返回缓存，同步请求数据
    ClientRequestNoCacheAgainRequest, // 忽略缓存，重新请求
    ClientRequestIfCacheDataElseAgainRequest,// 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    ClientRequestCacheOffLine,// 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};
@interface ClientRequestManger : AFHTTPSessionManager

//默认 ClientRequestCacheThenLoad
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                parameters:(id)parameters
                progress:(void (^)(NSProgress * downloadProgress))downloadProgress
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                   progress:(void (^)(NSProgress * downloadProgress))downloadProgress
                   cachePolicy:(ClientRequestCacheStatus)cachePolicy
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//默认 ClientRequestCacheThenLoad
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                    progress:(void (^)(NSProgress * downloadProgress))downloadProgress
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                    progress:(void (^)(NSProgress * downloadProgress))downloadProgress
                    cachePolicy:(ClientRequestCacheStatus)cachePolicy
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
