//
//  MyError.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/15.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  错误信息
 Error Domain=NSCocoaErrorDomain Code=516 "“5” couldn’t be copied to “Documents” because an item with the same name already exists." UserInfo={NSSourceFilePathErrorKey=/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/976BCDC7-7D2B-4C01-A948-A07BF057F275/Documents/5, NSUserStringVariant=(
 Copy
 ), NSDestinationFilePath=/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/976BCDC7-7D2B-4C01-A948-A07BF057F275/Documents/6, NSFilePath=/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/976BCDC7-7D2B-4C01-A948-A07BF057F275/Documents/5, NSUnderlyingError=0x7f90c8645070 {Error Domain=NSPOSIXErrorDomain Code=17 "File exists"}}
 */

/**
 *  字段对应
 (lldb) po error.domain
 NSCocoaErrorDomain
 
 (lldb) po error.code
 516
 
 (lldb) po error.localizedDescription
 “5” couldn’t be copied to “Documents” because an item with the same name already exists.
 
 (lldb) po error.localizedFailureReason
 A file with the name “5” already exists.
 
 (lldb) po error.localizedRecoveryOptions
 nil
 
 (lldb) po error.localizedRecoverySuggestion
 To save the file, either provide a different name, or move aside or delete the existing file, and try again.
 
 (lldb) po error.helpAnchor
 nil
 
 (lldb) po error.userInfo
 {
 NSDestinationFilePath = "/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/9E0150AE-82AE-4A9C-AC31-A5CE3BD05AAC/Documents/6";
 NSFilePath = "/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/9E0150AE-82AE-4A9C-AC31-A5CE3BD05AAC/Documents/5";
 NSSourceFilePathErrorKey = "/Users/YiSheng/Library/Developer/CoreSimulator/Devices/710F5160-D2DE-4DD8-9EA8-22A1542EFEF3/data/Containers/Data/Application/9E0150AE-82AE-4A9C-AC31-A5CE3BD05AAC/Documents/5";
 NSUnderlyingError = "Error Domain=NSPOSIXErrorDomain Code=17 \"File exists\"";
 NSUserStringVariant =     (
 Copy
 );
 }
 
 */

@interface MyError : NSError

@end
