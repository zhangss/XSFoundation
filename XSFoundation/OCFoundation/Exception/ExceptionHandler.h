//
//  ExceptionHandler.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExceptionHandler : NSObject

+ (instancetype)sharedInstance;

- (void)addAutoCatchException;

@end
