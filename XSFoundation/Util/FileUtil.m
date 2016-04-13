//
//  FileUtil.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+ (NSString *)documentPath
{
//    NSString *documentPath = [NSString stringWithFormat: @"%@/Documents/", NSHomeDirectory()];

    //获取存档对象的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = [paths objectAtIndex:0];
    return documentPath;
}

+ (BOOL)isExistDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory)
    {
//        [[HybridLogger sharedInstance] info:@"目录存在"];
        return YES;
    }
//    [[HybridLogger sharedInstance] error:@"目录不存在"];
    return NO;
}

+ (BOOL)createDirectory:(NSString *)path
{
    if ([FileUtil isExistDirectory:path])
    {
        return YES;
    }
    else
    {
        NSError *error = nil;
        NSFileManager *fm = [NSFileManager defaultManager];
        BOOL isSuccess = [fm createDirectoryAtPath:path
             withIntermediateDirectories:YES
                              attributes:nil
                                   error:&error];
        if (isSuccess && error == nil)
        {
            return isSuccess;
        }
        else
        {
            NSLog(@"error:%@",error);
            return NO;
        }
    }
}

+ (BOOL)isExistFile:(NSString *)filePath
{
    //TODO:区别
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)createFile:(NSString *)filePath
{
    return NO;
}

@end
