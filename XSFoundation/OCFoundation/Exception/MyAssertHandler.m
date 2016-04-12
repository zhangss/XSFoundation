//
//  MyAssertHandler.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/12.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "MyAssertHandler.h"

@implementation MyAssertHandler

/**
 *  OC Method
 *
 *  @param selector 方法
 *  @param object   对象
 *  @param fileName 文件名
 *  @param line     行数
 *  @param format   额外信息
 */
- (void)handleFailureInMethod:(SEL)selector object:(id)object file:(NSString *)fileName lineNumber:(NSInteger)line description:(NSString *)format, ... {
    
    NSLog(@"NSAssert Failure: Method %@ for object %@ in %@#%li", NSStringFromSelector(selector), object, fileName, (long)line);
}

/**
 *  C Function
 *
 *  @param functionName 函数名
 *  @param fileName     文件名
 *  @param line         行数
 *  @param format       额外信息
 */
- (void)handleFailureInFunction:(NSString *)functionName file:(NSString *)fileName lineNumber:(NSInteger)line description:(NSString *)format, ... {
    NSLog(@"NSCAssert Failure: Function (%@) in %@#%li", functionName, fileName, (long)line);
}

- (void)addAssertHanderForThread {
    NSAssertionHandler *myHandler = [[MyAssertHandler alloc] init];
    //给当前的线程
    [[[NSThread currentThread] threadDictionary] setValue:myHandler
                                                   forKey:NSAssertionHandlerKey];
}

@end
