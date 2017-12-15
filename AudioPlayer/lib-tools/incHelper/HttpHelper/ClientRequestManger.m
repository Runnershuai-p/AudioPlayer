//
//  ClientRequestManger.m
//  Chamleon-newTemplate
//
//  Created by Foreveross BSL on 16/8/8.
//  Copyright © 2016年 Foreveross BSL. All rights reserved.//

#import "ClientRequestManger.h"
#import <YYCache/YYCache.h>
#import "NSJSONSerialization+BSLJSON.h"
static NSString * const ServiceURLString = @"http://localhost:8080/";
static NSString * const ClientRequestCache = @"ClientRequestCacheData";
typedef NS_ENUM(NSUInteger, ClientRequestType) {
      ClientRequest_GET = 0,
      ClientRequest_POST,
};
@implementation ClientRequestManger

#pragma mark - public Mothod
//优先使用缓存
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                    parameters:(id)parameters
                    progress:(void (^)(NSProgress *downloadProgress))downloadProgress
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self requestMethod:ClientRequest_GET urlString:URLString parameters:parameters progress:downloadProgress cachePolicy:ClientRequestCacheThenLoad success:success failure:failure];
}
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                   progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                   cachePolicy:(ClientRequestCacheStatus)cachePolicy
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self requestMethod:ClientRequest_GET urlString:URLString parameters:parameters progress:downloadProgress cachePolicy:cachePolicy success:success failure:failure];
}
//优先使用缓存
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                    progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self requestMethod:ClientRequest_POST urlString:URLString parameters:parameters progress:downloadProgress cachePolicy:ClientRequestCacheThenLoad success:success failure:failure];
}
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                   progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                   cachePolicy:(ClientRequestCacheStatus)cachePolicy
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self requestMethod:ClientRequest_POST urlString:URLString parameters:parameters progress:downloadProgress cachePolicy:cachePolicy success:success failure:failure];
}

#pragma mark - private Mothod
+ (NSURLSessionDataTask *)requestMethod:(ClientRequestType)type
                      urlString:(NSString *)URLString
                      parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      cachePolicy:(ClientRequestCacheStatus)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *cacheKey = URLString;
    if (parameters) {
        if (![NSJSONSerialization isValidJSONObject:parameters]) return nil;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [URLString stringByAppendingString:paramStr];
    }
    
    YYCache *cache = [[YYCache alloc] initWithName:ClientRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    id object = [cache objectForKey:cacheKey];
    
    
    switch (cachePolicy) {
        case ClientRequestCacheThenLoad: {//先返回缓存，同时请求
            if (object) {
                success(nil,object);
            }
            break;
        }
        case ClientRequestNoCacheAgainRequest: {//忽略本地缓存直接请求
            //不做处理，直接请求
            break;
        }
        case ClientRequestIfCacheDataElseAgainRequest: {//有缓存就返回缓存，没有就请求
            if (object) {//有缓存
                success(nil,object);
                return nil;
            }
            break;
        }
        case ClientRequestCacheOffLine: {//有缓存就返回缓存,从不请求（用于没有网络）
            if (object) {//有缓存
                success(nil,object);
            }
            return nil;//退出从不请求
        }
        default: {
            break;
        }
    }
    return [self requestMethod:type urlString:URLString parameters:parameters progress:downloadProgress cache:cache cacheKey:cacheKey success:success failure:failure];
    
}
+ (NSURLSessionDataTask *)requestMethod:(ClientRequestType)type
                            urlString:(NSString *)URLString
                            parameters:(id)parameters
                            progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                            cache:(YYCache *)cache
                            cacheKey:(NSString *)cacheKey
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
      switch (type) {
        case ClientRequest_GET:{
            
           return [[ClientRequestManger sharedClient] GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                success(task,responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
  /*
    return [[ClientRequestManger sharedClient] GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
   **/
            break;
        }
        case ClientRequest_POST:{
           return [[ClientRequestManger sharedClient] POST:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task,error);
            }];
/*
  return [[ClientRequestManger sharedClient] POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
 **/
            break;
        }
        default:
            break;
    }
    
}
/// URLString 应该是全url 上传单个文件
+ (NSURLSessionUploadTask *)upload:(NSString *)URLString filePath:(NSString *)filePath parameters:(id)parameters{
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSURLSessionUploadTask *uploadTask = [[ClientRequestManger sharedClient] uploadTaskWithRequest:request fromFile:fileUrl progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
    return uploadTask;
}

+ (instancetype)sharedClient{
    static ClientRequestManger *sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[ClientRequestManger alloc]init];
    });
    return sharedClient;
}
- (instancetype)init{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self = [super initWithBaseURL:[NSURL URLWithString:ServiceURLString] sessionConfiguration:configuration];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (self) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json",@"json/text" ,nil];
        self.requestSerializer.timeoutInterval = 5;
    }
    return self;
}



- (void)cancel{
    [[ClientRequestManger manager].operationQueue cancelAllOperations];
}
@end
