//
//  FileManagerTest.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/15.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FileManager.h"

@interface FileManagerTest : XCTestCase <NSFileManagerDelegate>

@end

@implementation FileManagerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testFileManager {
    /**
     *  模拟器测试结果
     1:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/10321BDC-BC82-4F9C-81D4-782C91D9EB52
     2:
     3:
     4:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/10321BDC-BC82-4F9C-81D4-782C91D9EB52
     5:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/10321BDC-BC82-4F9C-81D4-782C91D9EB52/tmp/
     6:/
     */
    NSLog(@"1:%@",NSHomeDirectory());
    NSLog(@"2:%@",NSUserName());
    NSLog(@"3:%@",NSFullUserName());
    NSLog(@"4:%@",NSHomeDirectoryForUser(NSUserName()));
    NSLog(@"5:%@",NSTemporaryDirectory());
    NSLog(@"6:%@",NSOpenStepRootDirectory());
    
    for (NSInteger j = NSUserDomainMask; j <= NSSystemDomainMask; j++)
    {
        for (NSInteger i = NSApplicationDirectory; i <= NSAllLibrariesDirectory; i++)
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(i, j, YES);
            NSLog(@"i:%ld j:%ld \npaths:%@",i,j,paths);
        }
    }
    
    
    NSFileManager *fm = [NSFileManager defaultManager];
    for (NSInteger j = NSUserDomainMask; j <= NSSystemDomainMask; j++)
    {
        for (NSInteger i = NSApplicationDirectory; i <= NSAllLibrariesDirectory; i++)
        {
            NSArray *paths = [fm URLsForDirectory:i inDomains:j];
            NSLog(@"i:%ld j:%ld \npaths:%@",i,j,paths);
        }
    }
    XCTAssertTrue(@"");
}

- (void)testPathUtil {
    /**
     *  
     
     2016-04-18 18:16:45.366 XSFoundation[3184:217334] 1:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Documents
     2016-04-18 18:16:45.366 XSFoundation[3184:217334] 2:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Documents/dir
     2016-04-18 18:16:45.366 XSFoundation[3184:217334] 5:
     2016-04-18 18:16:45.366 XSFoundation[3184:217334] 3:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Documents/dir.fileType
     2016-04-18 18:16:45.366 XSFoundation[3184:217334] 4:dir.fileType
     2016-04-18 18:16:45.366 XSFoundation[3184:217334] 5:fileType
     2016-04-18 18:16:45.366 XSFoundation[3184:217334] 6:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Documents/dir
     2016-04-18 18:16:45.367 XSFoundation[3184:217334] 7:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Documents
     2016-04-18 18:16:45.367 XSFoundation[3184:217334] 8:(
     "/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Documents/dir1",
     "/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Documents/dir2"
     )
     2016-04-18 18:16:45.367 XSFoundation[3184:217334] 9:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Desktop
     2016-04-18 18:16:45.368 XSFoundation[3184:217334] 10:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/D062BB53-5FAE-4236-9775-2BEDE213A007/Test
     2016-04-18 18:20:00.229 XSFoundation[3207:220757] 11:/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/739FBF61-0B09-48D3-841C-89E72377D0D6/Test
     */
    NSString *path = [FileManager documentsPath];
    NSLog(@"1:%@",path);
    path = [path stringByAppendingPathComponent:@"dir"];
    NSLog(@"2:%@",path);
    NSString *lastExtension = [path pathExtension];
    NSLog(@"5:%@",lastExtension);
    path = [path stringByAppendingPathExtension:@"fileType"];
    NSLog(@"3:%@",path);
    NSString *lastComp = [path lastPathComponent];
    NSLog(@"4:%@",lastComp);
    lastExtension = [path pathExtension];
    NSLog(@"5:%@",lastExtension);
    path = [path stringByDeletingPathExtension];
    NSLog(@"6:%@",path);
    path = [path stringByDeletingLastPathComponent];
    NSLog(@"7:%@",path);
    NSArray *paths = [path stringsByAppendingPaths:@[@"dir1",@"dir2"]];
    NSLog(@"8:%@",paths);
    path = @"~/Desktop";
    //将路径中代字符扩展成用户主目录（~）或指定用户的主目录（~user）
    path = [path stringByExpandingTildeInPath];
    NSLog(@"9:%@",path);
    path = @"~/Test/Desktop/..";
    //尝试解析路径中的符号链接
    path = [path stringByResolvingSymlinksInPath];
    NSLog(@"10:%@",path);
    //通过尝试解析~、..（父目录符号）、.（当前目录符号）和符号链接来标准化路径
    path = [path stringByStandardizingPath];
    NSLog(@"11:%@",path);
}

- (void)testCreateDirectory {
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [FileManager documentsPath];
    /**
     *  
     withIntermediateDirectories YES,循环创建路径中不存在的中间目录
     withIntermediateDirectories NO,不会循环创建，如果路径中包含不存在目录则失败报错。
     
     Error Domain=NSCocoaErrorDomain Code=4 "The file “1” doesn’t exist." UserInfo={NSFilePath=/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/9FA2A1DE-8C3C-48EB-8B0E-A463CEF8CBF2/Documents/2/2/3/4, NSUnderlyingError=0x7fca68d69a00 {Error Domain=NSPOSIXErrorDomain Code=2 "No such file or directory"}}
     */
//    NSString *targetPath = [path stringByAppendingPathComponent:@"5"]; //都正确
    NSString *targetPath = [path stringByAppendingPathComponent:@"5/1"]; //NO时失败
    [fm createDirectoryAtPath:targetPath
  withIntermediateDirectories:NO
                   attributes:nil
                        error:&error];
    NSLog(@"%@",[error description]);
    XCTAssertNotNil(error);
}

- (void)testCreateFile
{
    NSString *path = [FileManager documentsPath];
    NSString *string = @"ABCD内容22.￥￥￥";
    NSArray *array = [NSArray arrayWithObject:string];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:string forKey:@"content"];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [FileManager createFileAtPath:[path stringByAppendingPathComponent:@"fmFile"] :data];
    [FileManager writeToFile:[path stringByAppendingPathComponent:@"dataFile"] withData:data];
    [FileManager writeToFile:[path stringByAppendingPathComponent:@"stringFile"] withString:string];
    [FileManager writeToFile:[path stringByAppendingPathComponent:@"arrayFile.plist"] withArray:array];
    [FileManager writeToFile:[path stringByAppendingPathComponent:@"dicFile.plist"] withDictionary:dic];
    XCTAssertTrue(@"");
}

- (void)testContentsOfPath {
    NSString *path = [FileManager documentsPath];
    
    NSArray *array = [FileManager contentsOfDirectoryAtPath:path];
//    array = [[NSFileManager defaultManager] subpathsAtPath:path];
    array = [FileManager subpathsOfDirectoryAtPath:path];
    for (NSString *content in array) {
        NSLog(@"%@",content);
    }
    XCTAssertNotNil(array);
}

- (void)testCpoyContent {
    NSString *srcPath = [FileManager documentsPath];
    NSString *dstPath = [FileManager libraryCachesPath];
//    BOOL isSuceess = [FileManager copyItemAtPath:[srcPath stringByAppendingPathComponent:@"4"] toPath:dstPath]; //失败
    BOOL isSuceess = NO;
    isSuceess = [FileManager copyItemAtPath:[srcPath stringByAppendingPathComponent:@"6"] toPath:[srcPath stringByAppendingPathComponent:@"6"]];
//    isSuceess = [FileManager copyItemAtPath:[srcPath stringByAppendingPathComponent:@"6"] toPath:[srcPath stringByAppendingPathComponent:@"6"]]; //NO
//    BOOL isSuceess = [FileManager copyItemAtPath:[srcPath stringByAppendingPathComponent:@"arrayFile.plist"] toPath:[dstPath stringByAppendingPathComponent:@"arrayFile11.plist"]];
    
    //重命名
//    isSuceess = [FileManager moveItemAtPath:[srcPath stringByAppendingPathComponent:@"4"] toPath:[srcPath stringByAppendingPathComponent:@"7"]];
//    isSuceess = [FileManager moveItemAtPath:[srcPath stringByAppendingPathComponent:@"7"] toPath:[srcPath stringByAppendingPathComponent:@"7"]]; //YES
    
    XCTAssertTrue(isSuceess);
}

- (void)testIsDirectory {
    NSString *directory = [FileManager documentsPath];
    NSString *nonexistentDir = [directory stringByAppendingPathComponent:@"nonexistent"];
    NSString *file = [[directory stringByAppendingPathComponent:@"arrayFile"] stringByAppendingPathExtension:@"plist"];
    BOOL isDirectory = NO;
    isDirectory = [FileManager fileExistsAtPathIsDirectory:directory]; //YES
    isDirectory = [FileManager fileExistsAtPathIsDirectory:nonexistentDir]; //NO
    isDirectory = [FileManager fileExistsAtPathIsDirectory:file]; //NO

    isDirectory = [FileManager fileExistsAtPathIsFile:directory]; //NO
    isDirectory = [FileManager fileExistsAtPathIsFile:nonexistentDir]; //NO
    isDirectory = [FileManager fileExistsAtPathIsFile:file]; //YES
    
    isDirectory = [FileManager fileExistsAtPath:directory];  //YES
    isDirectory = [FileManager fileExistsAtPath:nonexistentDir]; //NO
    isDirectory = [FileManager fileExistsAtPath:file]; //YES
    
    NSString *path = @"/1/2/3";
    NSString *displayName = [FileManager displayNameAtPath:directory];
    displayName = [FileManager displayNameAtPath:nonexistentDir];
    displayName = [FileManager displayNameAtPath:file];
    displayName = [FileManager displayNameAtPath:path];
    
    /**
     *  
     <__NSArrayM 0x7fb522511b80>(
     /,
     Users,
     YiSheng,
     Library,
     Developer,
     CoreSimulator,
     Devices,
     710F5160-D2DE-4DD8-9EA8-22A1542EFEF3,
     data,
     Containers,
     Data,
     Application,
     AD0A0669-D4E8-4A5D-A2A8-08EFF0B2789A,
     Documents
     )
     */
    NSArray *components = [FileManager componentsToDisplayForPath:directory];
    components = [FileManager componentsToDisplayForPath:nonexistentDir];
    components = [FileManager componentsToDisplayForPath:file];
    components = [FileManager componentsToDisplayForPath:path];
    XCTAssertTrue(isDirectory);
}


- (void)testFileAttributes {
    /**
     *  
     attributesOfItemAtPath
     Printing description of attributes:
     {
     NSFileCreationDate = "2016-04-15 10:57:02 +0000";
     NSFileExtensionHidden = 0;
     NSFileGroupOwnerAccountID = 20;
     NSFileGroupOwnerAccountName = staff;
     NSFileModificationDate = "2016-04-15 10:57:02 +0000";
     NSFileOwnerAccountID = 501;
     NSFilePosixPermissions = 420;
     NSFileReferenceCount = 1;
     NSFileSize = 231;
     NSFileSystemFileNumber = 52677210;
     NSFileSystemNumber = 16777218;
     NSFileType = NSFileTypeRegular;
     }
     
     attributesOfFileSystemForPath
     Printing description of attributes:
     {
     NSFileSystemFreeNodes = 44487745;
     NSFileSystemFreeSize = 182221803520;
     NSFileSystemNodes = 122054153;
     NSFileSystemNumber = 16777218;
     NSFileSystemSize = 499933818880;
     }
     */
    NSString *directory = [FileManager documentsPath];
    NSString *file = [[directory stringByAppendingPathComponent:@"arrayFile"] stringByAppendingPathExtension:@"plist"];
    NSDictionary *attributes = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSLog(@"7:%@",[FileManager currentDirectoryPath]);
    attributes = [fm attributesOfItemAtPath:directory error:nil];
    attributes = [fm attributesOfFileSystemForPath:directory error:nil];
    attributes = [fm attributesOfItemAtPath:file error:nil];
    attributes = [fm attributesOfFileSystemForPath:file error:nil];
//    const char *str = [fm fileSystemRepresentationWithPath:file];
    XCTAssertTrue(YES);
}

#pragma mark - NSFileManagerDelegate -
- (void)testFMDelegate {
    NSFileManager *fm = [FileManager fileManagerWithDelegate:self];
    NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
    NSArray *contents = [fm contentsOfDirectoryAtURL:bundleURL
                          includingPropertiesForKeys:@[]
                                             options:NSDirectoryEnumerationSkipsHiddenFiles
                                               error:nil];
    for (NSString *file in contents) {
        [fm removeItemAtPath:file error:nil];
    }
}


/* fileManager:shouldRemoveItemAtPath: allows the delegate the opportunity to not remove the item at path. If the delegate returns YES from this method, the NSFileManager instance will attempt to remove the item. If the delegate returns NO from this method, the remove skips the item. If the item is a directory, no children of that item will be visited.
 
 If the delegate does not implement this method, the NSFileManager instance acts as if this method returned YES.
 */
- (BOOL)fileManager:(NSFileManager *)fileManager shouldRemoveItemAtPath:(NSString *)path
{
    //除了PNG以外，都可以删除
    if ([[path pathExtension] isEqualToString:@"png"])
    {
        return NO;
    }
    return YES;
}
- (BOOL)fileManager:(NSFileManager *)fileManager shouldRemoveItemAtURL:(NSURL *)URL
{
    //除了PNG以外，都可以删除
    if ([[URL pathExtension] isEqualToString:@"png"])
    {
        return NO;
    }
    return YES;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
