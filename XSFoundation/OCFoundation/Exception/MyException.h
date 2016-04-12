//
//  MyException.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/12.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  
 *  官方：https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Exceptions/Exceptions.html#//apple_ref/doc/uid/10000012-BAJGFBFB
 */

@interface MyException : NSException

- (void)showExceptionAlert;

@end
