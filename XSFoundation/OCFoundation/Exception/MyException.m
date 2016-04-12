//
//  MyException.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/12.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "MyException.h"

@implementation MyException

/**
 *  捕捉到异常之后弹出提示框
 */
- (void)showExceptionAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tips"
                                                    message:self.reason
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
}

@end
