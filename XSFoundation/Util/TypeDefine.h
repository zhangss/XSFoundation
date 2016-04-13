//
//  TypeDefine.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IntegerToString(i) [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:i]]

/**
 *  导致APP崩溃的类型
 */
typedef NS_ENUM(NSInteger, kExceptionType)
{
    /**
     *  C方法exit(0)
     */
    kExceptionTypeCExit_0,
    /**
     *  C方法abort()
     */
    kExceptionTypeCAbort,
    /**
     *  C方法assert(0)
     */
    kExceptionTypeCAssert_0,
    /**
     *  NSAssert(condition,desc)
     */
    kExceptionTypeNSAssert,
    /**
     *  NSParameterAssert(param)
     */
    kExceptionTypeNSParameterAssert,
    /**
     *  @throw exception
     */
    kExceptionTypeNSException,
    /**
     *  performSelector:@selector(nonexistentMethod)
     */
    kExceptionTypeNonexistentMethod,
    /**
     *  [array objectAtIndex:{>maxlength}];
     */
    kExceptionTypeOutOfBounds,
    /**
     *  [mutableDic setObject:nil forKey:@"key"]
     */
    kExceptionTypeKeyValueNil,
    /**
     *  [object setValue:@"1" forKey:@"nonexistentKey"];
     */
    kExceptionTypeKeyValueNonexistentKey,
    /**
     *  initWithNib:nil bundile:
     */
    kExceptionTypeInitWithNibNameNil,
    /**
     *  Warning level 3, kill Memory
     */
    kExceptionTypeMemoryWarning
};

@interface TypeDefine : NSObject

+ (NSString *)getExceptionTypeDispay:(kExceptionType)type;

@end
