//
//  FileManager.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/18.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文件操作相关学习
 *
 *  TODO:链接还没涉及
 *
 *  官方：https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html
 */

/**
 *  在沙箱（sandbox）中的，在文件读写权限上受到限制，只能在几个目录下读写文件：
 *  1.Documents：应用中用户数据可以放在这里，iTunes备份和恢复的时候会包括此目录
 *  2.tmp：存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
 *  3.Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 *  4.Library/Preferences：配置信息目录，存放NSUserDefaults的配置信息。
 
 *  iTunes在与iPhone同步时，备份所有的Documents和Library文件。
 *  iPhone在重启时，会丢弃所有的tmp文件。
 */

/**
 *  HomePath:
 /Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/05E83E91-8723-4D5D-8960-93750F20431F
 */

@interface FileManager : NSObject

#pragma mark - Main Path -
/**
 *  系统的根目录
 *
 *  @return /
 */
+ (NSString *)rootPath;

/**
 *  APP的根目录 ~
 *
 *  @return
 */
+ (NSString *)homePath;

/**
 *  APP的根目录
 *
 *  @return
 */
+ (NSString *)userPath;

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
 *  Library下Preferences目录
 *
 *  @return homePath/Library/Preferences
 */
+ (NSString *)libraryPreferencesPath;

#pragma mark - File Operation -
#pragma mark ADD
/**
 *  创建目录
 *  如果目录存在，返回YES
 *
 *  @param path 不能为空
 *
 *  @return
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path;

/**
 *  创建文件
 *  如果文件存在，覆盖文件内容并返回YES
 *  数组与字段存储成XML格式的plist文件
 *
 *  @param filePath
 *
 *  @return
 */
+ (BOOL)createFileAtPath:(NSString *)filePath :(NSData *)fileData;
/**
 *  推荐使用如下API创建文件
 */
+ (BOOL)writeToFile:(NSString *)filePath withData:(NSData *)fileData;
+ (BOOL)writeToFile:(NSString *)filePath withString:(NSString *)fileContent;
+ (BOOL)writeToFile:(NSString *)filePath withArray:(NSArray *)fileContent;
+ (BOOL)writeToFile:(NSString *)filePath withDictionary:(NSDictionary *)fileContent;

#pragma mark DELETE
/**
 *  删除一个文件/目录
 *  如果是目录，可以递归删除
 *
 *  @param path 可以为nil,返回YES
 *
 *  @return
 */
+ (BOOL)removeItemAtPath:(NSString *)path;

#pragma mark MODIFY
/**
 *  获取/修改当前操作的目录
 *  开发人员不推荐主动调用修改方法，一般应由defaultManager负责控制。
 *
 *  @param path
 *
 *  @return
 */
+ (NSString *)currentDirectoryPath;
+ (BOOL)changeCurrentDirectoryPath:(NSString *)path;

/**
 *  把srcPath内容拷贝到dstPath
 *  dstPath必须包含目标文件/目录名，该名字为拷贝之后的文件/目录名称
 *  srcPath不存在会报错
 *  dstPath已存在会报错，不会覆盖
 *
 *  @param srcPath 不能为nil
 *  @param dstPath 不能为nil
 *
 *  @return
 */
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

/**
 *  把srcPath内容移动到dstPath
 *  dstPath必须包含目标文件/目录名，该名字为拷贝之后的文件/目录名称
 *  srcPath不存在会报错
 *  dstPath已存在会报错，不会覆盖
 *
 *  @param srcPath 不能为nil
 *  @param dstPath 不能为nil
 *
 *  @return
 */
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

/**
 *  创建硬链接，把srcPath链接到dstPath
 *
 *  @param srcPath 不能为nil
 *  @param dstPath 不能为nil
 *
 *  @return
 */
+ (BOOL)linkItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

#pragma mark QUERY
/**
 *  获取目录内容，浅搜索shallow
 *  返回数组包含目中所有的文件名、目录名，不是全路径只是名称
 *  不会循环递归子目录，不包含隐藏文件
 *  发生错误时返回nil
 *
 *  @param path
 *
 *  @return
 */
+ (NSArray<NSString *> *)contentsOfDirectoryAtPath:(NSString *)path;
/**
 *  深度检索可能会非常耗时，谨慎使用
 */
+ (NSArray<NSString *> *)subpathsOfDirectoryAtPath:(NSString *)path;

#pragma mark OTHER
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

/**
 *  是否存在文件/目录
 *  不区分类型，只要存在就返回YES
 *
 *  @param filePath
 *
 *  @return
 */
+ (BOOL)fileExistsAtPath:(NSString *)path;

/**
 *  文件/目录的读/写/执行/删除权限判断
 *  文件/目录不存在，认为NO
 *
 *  @param path
 *
 *  @return
 */
+ (BOOL)isReadableFileAtPath:(NSString *)path;
+ (BOOL)isWritableFileAtPath:(NSString *)path;
+ (BOOL)isExecutableFileAtPath:(NSString *)path;
+ (BOOL)isDeletableFileAtPath:(NSString *)path;

/**
 *  文件/目录的显示名称
 *  不对path的存在性做校验
 *
 *  @param path
 *
 *  @return
 */
+ (NSString *)displayNameAtPath:(NSString *)path;

/**
 *  从根目录开始，所有的目录组件名称
 *
 *  @param path
 *
 *  @return
 */
+ (NSArray<NSString *> *)componentsToDisplayForPath:(NSString *)path;

#pragma mark - Attributes -
/**
 *  获取文件/目录的属性列表
 *  提供文件/目录的创建时间、修改时间、大小、类型等
 *
 *  @param filePath
 *
 *  @return
 */
+ (NSDictionary<NSString *, id> *)attributesOfItemAtPath:(NSString *)filePath;

/**
 *  获取目录所属的文件系统属性
 *  获取文件系统的大小，剩余空间
 *
 *  @param filePath
 *
 *  @return
 */
+ (NSDictionary<NSString *, id> *)attributesOfFileSystemForPath:(NSString *)filePath;

/**
 *  修改文件/目录属性
 *  可修改属性常用的为：创建\修改时间、是否显示后缀、是否繁忙、是否可变更、所属用户\用户组等
 *
 *  @param attributes
 *  @param filePath
 *
 *  @return
 */
+ (BOOL)setAttributes:(NSDictionary<NSString *, id> *)attributes :(NSString *)filePath;

#pragma mark - NSFileManagerDelegate -
/**
 *  FM的回调相关
 *
 *  @param delegate
 *
 *  @return
 */
+ (NSFileManager *)fileManagerWithDelegate:(id <NSFileManagerDelegate>)delegate;

#pragma mark - iCloud -

@end
