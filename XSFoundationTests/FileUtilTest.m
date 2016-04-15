//
//  FileUtilTest.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/15.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FileUtil.h"

@interface FileUtilTest : XCTestCase

@end

@implementation FileUtilTest

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

- (void)testFileUtil {
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

- (void)testCreateDirectory {
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [FileUtil documentsPath];
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
    NSString *path = [FileUtil documentsPath];
    NSString *string = @"ABCD内容22.￥￥￥";
    NSArray *array = [NSArray arrayWithObject:string];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:string forKey:@"content"];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [FileUtil createFileAtPath:[path stringByAppendingPathComponent:@"fmFile"] :data];
    [FileUtil writeToFile:[path stringByAppendingPathComponent:@"dataFile"] withData:data];
    [FileUtil writeToFile:[path stringByAppendingPathComponent:@"stringFile"] withString:string];
    [FileUtil writeToFile:[path stringByAppendingPathComponent:@"arrayFile.plist"] withArray:array];
    [FileUtil writeToFile:[path stringByAppendingPathComponent:@"dicFile.plist"] withDictionary:dic];
    XCTAssertTrue(@"");
}

- (void)testContentsOfPath {
    NSString *path = [FileUtil documentsPath];
    
    NSArray *array = [FileUtil contentsOfDirectoryAtPath:path];
//    array = [[NSFileManager defaultManager] subpathsAtPath:path];
    array = [FileUtil subpathsOfDirectoryAtPath:path];
    for (NSString *content in array) {
        NSLog(@"%@",content);
    }
    XCTAssertNotNil(array);
}

- (void)testCpoyContent {
    NSString *srcPath = [FileUtil documentsPath];
    NSString *dstPath = [FileUtil libraryCachesPath];
//    BOOL isSuceess = [FileUtil copyItemAtPath:[srcPath stringByAppendingPathComponent:@"4"] toPath:dstPath]; //失败
    BOOL isSuceess = NO;
    isSuceess = [FileUtil copyItemAtPath:[srcPath stringByAppendingPathComponent:@"6"] toPath:[srcPath stringByAppendingPathComponent:@"6"]];
//    isSuceess = [FileUtil copyItemAtPath:[srcPath stringByAppendingPathComponent:@"6"] toPath:[srcPath stringByAppendingPathComponent:@"6"]]; //NO
//    BOOL isSuceess = [FileUtil copyItemAtPath:[srcPath stringByAppendingPathComponent:@"arrayFile.plist"] toPath:[dstPath stringByAppendingPathComponent:@"arrayFile11.plist"]];
    
    //重命名
//    isSuceess = [FileUtil moveItemAtPath:[srcPath stringByAppendingPathComponent:@"4"] toPath:[srcPath stringByAppendingPathComponent:@"7"]];
//    isSuceess = [FileUtil moveItemAtPath:[srcPath stringByAppendingPathComponent:@"7"] toPath:[srcPath stringByAppendingPathComponent:@"7"]]; //YES
    
    XCTAssertTrue(isSuceess);
}

- (void)testIsDirectory {
    NSString *directory = [FileUtil documentsPath];
    NSString *nonexistentDir = [directory stringByAppendingPathComponent:@"nonexistent"];
    NSString *file = [[directory stringByAppendingPathComponent:@"arrayFile"] stringByAppendingPathExtension:@"plist"];
    BOOL isDirectory = NO;
    isDirectory = [FileUtil fileExistsAtPathIsDirectory:directory]; //YES
    isDirectory = [FileUtil fileExistsAtPathIsDirectory:nonexistentDir]; //NO
    isDirectory = [FileUtil fileExistsAtPathIsDirectory:file]; //NO

    isDirectory = [FileUtil fileExistsAtPathIsFile:directory]; //NO
    isDirectory = [FileUtil fileExistsAtPathIsFile:nonexistentDir]; //NO
    isDirectory = [FileUtil fileExistsAtPathIsFile:file]; //YES
    
    isDirectory = [FileUtil fileExistsAtPath:directory];  //YES
    isDirectory = [FileUtil fileExistsAtPath:nonexistentDir]; //NO
    isDirectory = [FileUtil fileExistsAtPath:file]; //YES
    XCTAssertTrue(isDirectory);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
