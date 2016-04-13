//
//  NSException+Process.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (Process)

- (void)showExceptionAlert;

- (void)showExceptionWithEmail;

- (void)writeExceptionToFile;

@end
