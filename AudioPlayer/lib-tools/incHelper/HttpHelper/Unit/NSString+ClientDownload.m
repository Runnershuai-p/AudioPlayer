//
//  NSString+ClientDownload.m
//  Chamleon-newTemplate
//
//  Created by Foreveross BSL on 16/8/23.
//  Copyright © 2016年 Foreveross BSL. All rights reserved.
//

#import "NSString+ClientDownload.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (ClientDownload)
- (NSString *)XMAF_md5 {
    
    NSData* inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    
    NSMutableString* hashStr = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [hashStr appendFormat:@"%02x", outputData[i]];
    
    return hashStr;
    
}
@end
