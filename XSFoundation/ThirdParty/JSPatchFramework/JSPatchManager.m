//
//  JSPatchManager.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/22.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "JSPatchManager.h"

@implementation JSPatchManager

+ (void)start
{
    [JSPatch startWithAppKey:JSPacthAPPKey];
}

+ (void)sync
{
    [JSPatch sync];
}

+ (void)log:(NSString *)msg
{
    [JSPatch setupLogger:^(NSString *msg) {
        NSLog(@"%@",msg);
    }];
}

+ (void)testScriptInBundle
{
    [JSPatch testScriptInBundle];
}


+ (void)bugTest
{
    NSArray *array = [NSArray array];
    [array objectAtIndex:1];
}

@end
