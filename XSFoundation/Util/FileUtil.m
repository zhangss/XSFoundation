//
//  FileUtil.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

#pragma mark - Main Path -
+ (NSString *)rootPath
{
    return NSOpenStepRootDirectory();
}

+ (NSString *)homePath
{
    return NSHomeDirectory();
}

+ (NSString *)userPath
{
    NSString *userName = NSUserName();
    return NSHomeDirectoryForUser(userName);
}

+ (NSString *)documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = [paths objectAtIndex:0];
    return documentPath;
}

+ (NSString *)tempPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)libraryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *libraryPath = [paths objectAtIndex:0];
    return libraryPath;
}

+ (NSString *)libraryCachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    return cachesPath;
}

+ (NSString *)libraryPreferencesPath
{
    return [[FileUtil libraryPath] stringByAppendingPathComponent:@"Preferences"];
}

#pragma mark - File Operation -
#pragma mark ADD
+ (BOOL)createDirectoryAtPath:(NSString *)path
{
    /**
     *  
     Creates a directory with given attributes at the specified path.
     YES if the directory was created, YES if createIntermediates is set and the directory already exists), or NO if an error occurred.
     Parameters
     path
     A path string identifying the directory to create. You may specify a full path or a path that is relative to the current working directory. This parameter must not be nil.
     createIntermediates
     YES时，如果Path中有不存在的目录，则创建出来
     NO是，如果有不存在的目录，则失败报错
     If YES, this method creates any non-existent parent directories as part of creating the directory in path. 
     If NO, this method fails if any of the intermediate中间体 parent directories does not exist. This method also fails if any of the intermediate path elements corresponds to a file and not a directory.
     attributes
     The file attributes for the new directory and any newly created intermediate directories. You can set the owner and group numbers, file permissions, and modification date. If you specify nil for this parameter or omit a particular value, one or more default values are used as described in the discussion. For a list of keys you can include in this dictionary, see Constants section lists the global constants used as keys in the attributes dictionary. Some of the keys, such as NSFileHFSCreatorCode and NSFileHFSTypeCode, do not apply to directories.
     error
     On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information. You may specify nil for this parameter if you do not want the error information.
     Returns	YES if the directory was created, YES if createIntermediates is set and the directory already exists), or NO if an error occurred.
     */
    NSParameterAssert(path);
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

+ (BOOL)createFileAtPath:(NSString *)filePath :(NSData *)fileData
{
    /**
     *  
     *  创建文件操作不推荐使用NSFileMananger，推荐直接使用writeToFile
     These methods are provided here for compatibility. The corresponding methods on NSData which return NSErrors should be regarded as the primary method of creating a file from an NSData or retrieving the contents of a file as an NSData.
     
     Creates a file with the specified content and attributes at the given location.
     YES if the operation was successful or if the item already exists, otherwise NO.
     Parameters
     path
     The path for the new file.
     contents
     A data object containing the contents of the new file.
     attributes
     A dictionary containing the attributes to associate with the new file. You can use these attributes to set the owner and group numbers, file permissions, and modification date. For a list of keys, see File Attribute Keys. If you specify nil for attributes, the file is created with a set of default attributes.
     Returns	YES if the operation was successful or if the item already exists, otherwise NO.
     */
    return [[NSFileManager defaultManager] createFileAtPath:filePath
                                                   contents:fileData
                                                 attributes:nil];
}

+ (BOOL)writeToFile:(NSString *)filePath withData:(NSData *)fileData
{
    /**
     *
     Writes the bytes in the receiver to the file specified by a given path.
     YES if the operation succeeds, otherwise NO.
     Parameters
     path
     The location to which to write the receiver's bytes. If path contains a tilde (~) character, you must expand it with stringByExpandingTildeInPath before invoking this method.
     atomically
     YES的话先写到备份文件中，如果没有错误发生，在重命名到指定目录。确保写入正常才会写入。
     NO的话直接写入指定目录
     If YES, the data is written to a backup file, and then—assuming no errors occur—the backup file is renamed to the name specified by path; otherwise, the data is written directly to path.
     Returns	YES if the operation succeeds, otherwise NO.
     */
    return [fileData writeToFile:filePath atomically:YES];
}

+ (BOOL)writeToFile:(NSString *)filePath withString:(NSString *)fileContent
{
    /**
     * 
     Writes the contents of the receiver to a file at a given path using a given encoding.
     YES if the file is written successfully, otherwise NO (if there was a problem writing to the file or with the encoding).
     Parameters
     path
     The file to which to write the receiver. If path contains a tilde (~) character, you must expand it with stringByExpandingTildeInPath before invoking this method.
     useAuxiliaryFile
     If YES, the receiver is written to an auxiliary辅助补救 file, and then the auxiliary file is renamed to path. If NO, the receiver is written directly to path. The YES option guarantees that path, if it exists at all, won’t be corrupted损坏 even if the system should crash during writing.
     enc
     The encoding to use for the output.
     error
     If there is an error, upon return contains an NSError object that describes the problem. If you are not interested in details of errors, you may pass in NULL.
     Returns	YES if the file is written successfully, otherwise NO (if there was a problem writing to the file or with the encoding).
     */
    return [fileContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (BOOL)writeToFile:(NSString *)filePath withArray:(NSArray *)fileContent
{
    /**
     *
     Writes the contents of the array to a file at a given path.
     YES if the file is written successfully, otherwise NO.
     Parameters
     path
     The path at which to write the contents of the array.
     If path contains a tilde (~) character, you must expand it with stringByExpandingTildeInPath before invoking this method.
     flag
     If YES, the array is written to an auxiliary file, and then the auxiliary file is renamed to path. If NO, the array is written directly to path. The YES option guarantees that path, if it exists at all, won’t be corrupted even if the system should crash during writing.
     Returns	YES if the file is written successfully, otherwise NO.
     */
    return [fileContent writeToFile:filePath atomically:YES];
}

+ (BOOL)writeToFile:(NSString *)filePath withDictionary:(NSDictionary *)fileContent
{
    /**
     *  plist文件
     Writes a property list representation of the contents of the dictionary to a given path.
     YES if the file is written successfully, otherwise NO.
     Parameters
     path
     The path at which to write the file.
     If path contains a tilde (~) character, you must expand it with stringByExpandingTildeInPath before invoking this method.
     flag
     A flag that specifies whether the file should be written atomically.
     If flag is YES, the dictionary is written to an auxiliary file, and then the auxiliary file is renamed to path. If flag is NO, the dictionary is written directly to path. The YES option guarantees that path, if it exists at all, won’t be corrupted even if the system should crash during writing.
     Returns	YEStrue if the file is written successfully, otherwise NOfalse.
     */
    return [fileContent writeToFile:filePath atomically:YES];
}

#pragma mark DELETE
+ (BOOL)removeItemAtPath:(NSString *)path
{
    /**
     *  删除文件/目录
     Removes the file or directory at the specified path.
     Returns YES if the item was removed successfully or if path was nil.
     Returns NO if an error occurred.
     If the delegate stops the operation for a file, this method returns YES. However, if the delegate stops the operation for a directory, this method returns NO.
     
     Parameters
     path
     A path string indicating the file or directory to remove. If the path specifies a directory, the contents of that directory are recursively递归的 removed. You may specify nil for this parameter.
     error
     On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information. You may specify nil for this parameter if you do not want the error information.
     Returns	YES if the item was removed successfully or if path was nil.
     */
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isSuccess = [fm removeItemAtPath:path error:&error];
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

#pragma mark MODIFY
+ (BOOL)changeCurrentDirectoryPath:(NSString *)path
{
    /**
     * 修改当前的操作目录。这件事情应该由defaultManager负责，开发人员不要调用此方法。
     *
     Process working directory management. Despite尽管 the fact that these are instance methods on NSFileManager, these methods report and change (respectively依次的) the working directory for the entire process. 
     Developers are cautioned警告 that doing so is fraught充满 with peril危险.
     
     Changes the path of the current working directory to the specified path.
     YES if successful, otherwise NO.
     Parameters
     path
     The path of the directory to which to change.
     Returns	YES if successful, otherwise NO.
     */
    return [[NSFileManager defaultManager] changeCurrentDirectoryPath:path];
}

+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
{
    /**
     *  TODO:拷贝不完整，算成功么？
     *
     Copies the item at the specified path to a new location synchronously同步.
     YES if the item was copied successfully or the file manager’s delegate stopped the operation deliberately有意的/故意的. Returns NO if an error occurred.
     Parameters
     srcPath
     The path to the file or directory you want to move. This parameter must not be nil.
     dstPath
     The path at which to place the copy of srcPath. This path must include the name of the file or directory in its new location. This parameter must not be nil.
     error
     On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information. You may specify nil for this parameter if you do not want the error information.
     Returns	YES if the item was copied successfully or the file manager’s delegate stopped the operation deliberately.
     */
    /**
     *  
     scrPath不存在错误
     Error Domain=NSCocoaErrorDomain Code=260 "The file “4” couldn’t be opened because there is no such file." UserInfo={NSFilePath=/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/1A8D96CE-C185-4FA4-A1A9-3C474AB60021/Documents/4, NSUnderlyingError=0x7f879b534dd0 {Error Domain=NSPOSIXErrorDomain Code=2 "No such file or directory"}}
     
     dstPath已存在错误
     Error Domain=NSCocoaErrorDomain Code=516 "“5” couldn’t be copied to “Documents” because an item with the same name already exists." UserInfo={NSSourceFilePathErrorKey=/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/976BCDC7-7D2B-4C01-A948-A07BF057F275/Documents/5, NSUserStringVariant=(
     Copy
     ), NSDestinationFilePath=/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/976BCDC7-7D2B-4C01-A948-A07BF057F275/Documents/6, NSFilePath=/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/976BCDC7-7D2B-4C01-A948-A07BF057F275/Documents/5, NSUnderlyingError=0x7f90c8645070 {Error Domain=NSPOSIXErrorDomain Code=17 "File exists"}}
     */
    NSParameterAssert(srcPath);
    NSParameterAssert(dstPath);
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isSuccess = [fm copyItemAtPath:srcPath toPath:dstPath error:&error];
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

+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
{
    /**
     *  TODO:拷贝不完整，算成功么？
     *
     Moves the file or directory at the specified path to a new location synchronously.
     YES if the item was moved successfully or the file manager’s delegate stopped the operation deliberately. Returns NO if an error occurred.
     Parameters
     srcPath
     The path to the file or directory you want to move. This parameter must not be nil.
     dstPath
     The new path for the item in srcPath. This path must include the name of the file or directory in its new location. This parameter must not be nil.
     error
     On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information. You may specify nil for this parameter if you do not want the error information.
     Returns	YES if the item was moved successfully or the file manager’s delegate stopped the operation deliberately.
     */
    NSParameterAssert(srcPath);
    NSParameterAssert(dstPath);
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isSuccess = [fm moveItemAtPath:srcPath toPath:dstPath error:&error];
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

+ (BOOL)linkItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
{
    /**
     *  TODO:Link没用过
     *
     Creates a hard link between the items at the specified paths.
     YES if the hard link was created or NO if an error occurred. This method also returns NO if a file, directory, or link already exists at dstPath.
     Parameters
     srcPath
     The path that specifies the item you wish to link to. The value in this parameter must not be nil.
     dstPath
     The path that identifies the location where the link will be created. The value in this parameter must not be nil.
     error
     On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information. You may specify nil for this parameter if you do not want the error information.
     Returns	YES if the hard link was created or NO if an error occurred.
     */
    NSParameterAssert(srcPath);
    NSParameterAssert(dstPath);
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isSuccess = [fm linkItemAtPath:srcPath toPath:dstPath error:&error];
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

#pragma mark QUERY
+ (NSArray<NSString *> *)contentsOfDirectoryAtPath:(NSString *)path
{
    /**
     *  
     contentsOfDirectoryAtPath:error: returns an NSArray of NSStrings representing the filenames of the items in the directory. If this method returns 'nil', an NSError will be returned by reference in the 'error' parameter. If the directory contains no items, this method will return the empty array.
     
     This method replaces directoryContentsAtPath:
     
     Performs a shallow浅/表层 search of the specified directory and returns the paths of any contained items.
     An array of NSString objects, each of which identifies a file, directory, or symbolic link contained in path. Returns an empty array if the directory exists but has no contents. If an error occurs, this method returns nil and assigns an appropriate error object to the error parameter
     Parameters
     path
     The path to the directory whose contents you want to enumerate.
     error
     On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information. You may specify nil for this parameter if you do not want the error information.
     Returns	An array of NSString objects, each of which identifies a file, directory, or symbolic link contained in path.
     */
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *contents = [fm contentsOfDirectoryAtPath:path error:&error];
    [fm copyItemAtPath:path toPath:path error:&error];
    if (error != nil)
    {
        NSLog(@"error:%@",error);
    }
    return contents;
}

+ (NSArray<NSString *> *)subpathsOfDirectoryAtPath:(NSString *)path
{
    /**
     *  链接文件的目标文件丢失时，也会返回nil。
     *  操作可能会非常耗时，谨慎使用。
     *
     This may be very expensive to compute for deep filesystem hierarchies, and should probably be avoided.
     
     Performs a deep enumeration列举/计算 of the specified directory and returns the paths of all of the contained subdirectories子目录.
     An array of NSString objects, each of which contains the path of an item in the directory specified by path. If path is a symbolic link, this method traverses遍历 the link. This method returns nil if it cannot retrieve检索/找回 the device of the linked-to file.
     Parameters
     path
     The path of the directory to list.
     error
     If an error occurs, upon return contains an NSError object that describes the problem. Pass NULL if you do not want error information.
     Returns	An array of NSString objects, each of which contains the path of an item in the directory specified by path.
     */
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *contents = [fm subpathsOfDirectoryAtPath:path error:&error];
//    [fm subpathsAtPath:path]; //NS_DEPRECATED
    if (error != nil)
    {
        NSLog(@"error:%@",error);
    }
    return contents;
}

#pragma mark OTHER
+ (BOOL)fileExistsAtPathIsDirectory:(NSString *)path
{
    /**
     *
     Returns a Boolean value that indicates whether a file or directory exists at a specified path. The isDirectory out parameter indicates whether the path points to a directory or a regular file.
     YES if a file at the specified path exists, or NO if the file’s does not exist or its existence could not be determined.
     Parameters
     path
     The path of a file or directory. If path begins with a tilde (~), it must first be expanded with stringByExpandingTildeInPath, or this method will return NO.
     isDirectory
     Upon return, contains YES if path is a directory or if the final path element is a symbolic link that points to a directory; otherwise, contains NO. If path doesn’t exist, this value is undefined upon return. Pass NULL if you do not need this information.
     Returns	YES if a file at the specified path exists, or NO if the file’s does not exist or its existence could not be determined.
     */
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

+ (BOOL)fileExistsAtPath:(NSString *)filePath;
{
    /**
     *  
     Returns a Boolean value that indicates whether a file or directory exists at a specified path.
     YES if a file at the specified path exists, or NO if the file does not exist or its existence could not be determined.
     Parameters
     path
     The path of the file or directory. If path begins with a tilde (~), it must first be expanded with stringByExpandingTildeInPath; otherwise, this method returns NO.
     App Sandbox does not restrict which path values may be passed to this parameter.
     Returns	YES if a file at the specified path exists, or NO if the file does not exist or its existence could not be determined.
     */
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

@end
