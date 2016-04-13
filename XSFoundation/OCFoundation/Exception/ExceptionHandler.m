//
//  ExceptionHandler.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "ExceptionHandler.h"
#import "MyException.h"
#import "NSException+Process.h"

@implementation ExceptionHandler

static ExceptionHandler *instance = nil;
+ (ExceptionHandler *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ExceptionHandler alloc] init];
    });
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)addAutoCatchException
{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

#pragma mark -
#pragma mark 异常捕获
void UncaughtExceptionHandler(NSException *exception)
{
    //异常处理,捕获之后无法阻止程序崩溃
    [exception showExceptionAlert];
}

void SignalHandler(int sig)
{
    NSArray *arr = [NSThread callStackSymbols];
    NSString *reason = [NSString stringWithFormat:@"SignalHandler: %d", sig];
    NSString *name = [[NSThread currentThread] name];
    NSDictionary *callStack = [NSDictionary dictionaryWithObjectsAndKeys:arr,NSAssertionHandlerKey, nil];
    MyException *exception = [[MyException alloc] initWithName:name
                                                        reason:reason
                                                      userInfo:callStack];
    [exception showExceptionWithEmail];
}


#pragma mark -
#pragma mark KVC
/**
 *  重写如下两个方法可以屏蔽KVC找不到key时的异常
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (id)valueForUndefinedKey:(NSString *)key;
{
    return @"";
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    [self willChangeValueForKey:key];
    //TODO:runtime绑定一个key上去
    //
//    [self didChangeValueForKey:key];
}


@end
