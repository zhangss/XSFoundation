//
//  DataUtil.m
//  XSFoundation
//
//  Created by 张松松 on 16/8/29.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil


+ (NSString *)formatDataSize:(double)size
{
    return [DataUtil formatDataSizeIniOS:size];
}


/**
 *  格式化输出Data的大小，
 *  不准确,可能是计算方式问题 //:TODO
 *
 *  @param size
 *
 *  @return
 */
+ (NSString *)formatDataSizeByCalculate:(double)size
{
    int multiplyFactor = 0;
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB", nil];
    while (size > 1024) {
        size /= 1024;
        multiplyFactor ++;
    }
    return [NSString stringWithFormat:@"%4.2f %@",size, [tokens objectAtIndex:multiplyFactor]];
}

/**
 *  格式化输出Data的大小，
 *  准确，与电脑磁盘统计显示一致
 *
 *  @param size
 *
 *  @return
 */
+ (NSString *)formatDataSizeIniOS:(double)size
{
    NSString *formateString = [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
    return formateString;
}

@end
