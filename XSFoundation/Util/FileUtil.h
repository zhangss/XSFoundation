//
//  FileUtil.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

+ (NSString *)documentPath;


+ (BOOL)isExistDirectory:(NSString *)path;

+ (BOOL)createDirectory:(NSString *)path;

+ (BOOL)isExistFile:(NSString *)filePath;

+ (BOOL)createFile:(NSString *)filePath;

@end
