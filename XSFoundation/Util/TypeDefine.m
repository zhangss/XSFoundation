//
//  TypeDefine.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "TypeDefine.h"

@implementation TypeDefine

+ (NSString *)getExceptionTypeDispay:(kExceptionType)type
{
    NSString *desc = @"";
    switch (type) {
        case kExceptionTypeCExit_0:
            desc = @"exit(0)";
            break;
        case kExceptionTypeCAbort:
            desc = @"abort()";
            break;
        case kExceptionTypeCAssert_0:
            desc = @"assert(0)";
            break;
        case kExceptionTypeNSAssert:
            desc = @"NSAssert(condition,desc)";
            break;
        case kExceptionTypeNSParameterAssert:
            desc = @"NSParamterAssert(param)";
            break;
        case kExceptionTypeNSException:
            desc = @"@throw excption";
            break;
        case kExceptionTypeNonexistentMethod:
            desc = @"[self performSelector:@selector(nonexistentMethod)]";
            break;
        case kExceptionTypeOutOfBounds:
            desc = @"[array objectAtIndex:array.count]";
            break;
        case kExceptionTypeKeyValueNil:
            desc = @"[mutableDic setObject:nil forKey:@\"key\"]";
            break;
        case kExceptionTypeKeyValueNonexistentKey:
            desc = @"[object setValue:@\"1\" forKey:@\"nonexistentKey\"]";
            break;
        case kExceptionTypeInitWithNibNameNil:
            desc = @"[[vc alloc] initWithNib:nil bundile:mainbundle]";
            break;
        case kExceptionTypeMemoryWarning:
            desc = @"killMemory";
            break;
        default:
            desc = @"unKnow";
            break;
    }
    return desc;
}

@end
