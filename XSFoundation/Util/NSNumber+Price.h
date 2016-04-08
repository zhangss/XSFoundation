//
//  NSNumber+Price.h
//  XSFoundation
//
//  Created by 张松松 on 15/12/26.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Price)

/**
 *  获取金额显示字符串，单位从“分”转为“元”，有小数则显示2位，无则不显示
 *
 *  @return
 */
- (NSString *)priceDecimalStringValue;

/**
 *  从输入框获取价格数字 以分为单位，传给服务端
 *
 *  @return
 */
+ (NSNumber *)priceDecimalFromString:(NSString *)price;

@end
