//
//  FileUtil.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+ (NSString *)documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = [paths firstObject];
    return documentPath;
}

+ (NSString *)tempPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)libraryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *libraryPath = [paths firstObject];
    return libraryPath;
}

+ (NSString *)libraryCachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cachesPath = [paths firstObject];
    return cachesPath;
}

+ (BOOL)fileExistsAtPathIsDirectory:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if ([fm fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory)
    {
        return isDirectory;
    }
    
    return NO;
}

+ (BOOL)fileExistsAtPathIsFile:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    if ([fm fileExistsAtPath:path isDirectory:&isDirectory] && !isDirectory)
    {
        return !isDirectory;
    }
    return NO;
}

+ (BOOL)isDirectory:(NSString *)path
{
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attrs = [fm attributesOfItemAtPath:path error:&error];
    if (error != nil)
    {
        NSLog(@"error:%@",error);
    }
    if (attrs && [attrs fileType] == NSFileTypeDirectory) {
        return YES;
    }
    return NO;
}


@end
