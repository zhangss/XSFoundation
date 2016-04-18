//
//  FileUtil.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

/**
 *  Documents目录
 *
 *  @return homePath/Documents
 */
+ (NSString *)documentsPath;

/**
 *  temp目录
 *
 *  @return homePath/tmp/
 */
+ (NSString *)tempPath;

/**
 *  Library目录
 *
 *  @return homePath/Library
 */
+ (NSString *)libraryPath;

/**
 *  Library下Caches目录
 *
 *  @return homePath/Library/Caches
 */
+ (NSString *)libraryCachesPath;

/**
 *  是否存在文件/目录
 *  如果Path存在，但是类型不对，返回NO
 *
 *  @param path
 *
 *  @return
 */
+ (BOOL)fileExistsAtPathIsDirectory:(NSString *)path;
+ (BOOL)fileExistsAtPathIsFile:(NSString *)path;
+ (BOOL)isDirectory:(NSString *)path;

@end
