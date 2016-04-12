//
//  MyAssertHandler.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/12.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  自定义处理方法,程序有可能继续运行,不会强制退出程序.
 *  参考：http://www.cocoachina.com/ios/20150513/11806.html
 */

@interface MyAssertHandler : NSAssertionHandler

@end
