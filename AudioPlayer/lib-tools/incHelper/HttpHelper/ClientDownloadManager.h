//
//  ClientDownloadManager.h
//  Chamleon-newTemplate
//
//  Created by Foreveross BSL on 16/8/23.
//  Copyright © 2016年 Foreveross BSL. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ClientDownloadProgressBlock)(int64_t bytes,int64_t totalBytes);
typedef void(^ClientDownloadCompleteBlock)(NSString *filePath, NSError *error);
typedef NSDictionary *(^ClientDownloadConstructBlock)();

@interface ClientDownloadManager : NSObject
@property (copy, nonatomic, readonly) NSArray *downloadTasks;

+ (instancetype)manager;
- (instancetype)initWithCachePath:(NSString *)cachePath;

- (void)cleanDownloadingCache;
- (void)cleanDownloadedCahce;

/**
 *  下载文件
 *
 *  @param URLString     下载地址
 *  @param fileName      下载文件名
 *  @param progressBlock 进度条block
 *  @param completeBlock 完成block
 *
 *  @return NSURLSessionDownloadTask 实例
 */
- (NSURLSessionDownloadTask *)downloadWithURLString:(NSString *)URLString fileName:(NSString *)fileName progressBlock:(ClientDownloadProgressBlock)progressBlock completeBlock:(ClientDownloadCompleteBlock)completeBlock;

/**
 *  下载文件
 *
 *  @param constructBlock 构造block,返回NSDictionary类型
 *  @param progressBlock  进度条block
 *  @param completeBlock  完成block
 *
 *  @return NSURLSessionDownloadTask 实例
 */
- (NSURLSessionDownloadTask *)downloadWithConstructBlock:(ClientDownloadConstructBlock)constructBlock progressBlock:(ClientDownloadProgressBlock)progressBlock completeBlock:(ClientDownloadCompleteBlock)completeBlock;

- (void)suspendTasks;
- (void)cancelTasks;
- (void)cancelTask:(NSURLSessionDownloadTask *)downloadTask;
@end
