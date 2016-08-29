//
//  XSConfig.m
//  XSFoundation
//
//  Created by 张松松 on 16/8/29.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "XSConfig.h"

@implementation XSConfig

#pragma mark - Instance -
static XSConfig *shareConfig = nil;
+ (XSConfig *)shareConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareConfig == nil)        {
            shareConfig = [[self alloc] init];
        }
    });
    return shareConfig;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if(shareConfig == nil)
        {
            shareConfig = [super allocWithZone:zone];
            return shareConfig;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - File System -
- (NSString *)imageCompressionPath
{
    NSString *documentPath = [FileManager documentsPath];
    NSString *compressionPath = [documentPath stringByAppendingPathComponent:@"ImageCompressionTest"];
    [FileManager createDirectoryAtPath:compressionPath];
    return compressionPath;
}

@end
