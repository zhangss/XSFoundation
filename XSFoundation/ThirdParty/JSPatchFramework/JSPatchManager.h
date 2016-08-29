//
//  JSPatchManager.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/22.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSPatch/JSPatch.h>

#define JSPacthAPPKey @"ed82cd427a182812"
#define JSPatchFramework
#define JSPatchFrameworkTest

@interface JSPatchManager : NSObject

/**
 *  启动JSPatch框架
 */
+ (void)start;

/**
 *  检查是否有脚本更新，如果更新则会自动下载并执行
 *  推荐每次启动调用，实时性需求高的话可以每次进入前台时调用
 */
+ (void)sync;

/**
 *  日志信息输入出
 *
 *  @param msg
 */
+ (void)log:(NSString *)msg;

/**
 *  测试脚本
 */
+ (void)testScriptInBundle;

/**
 *  崩溃bug测试，执行app bundle里面的main.js
 *  测试时只能单独调用这个API
 */
+ (void)bugTest;

@end
