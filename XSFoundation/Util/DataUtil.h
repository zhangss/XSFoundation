//
//  DataUtil.h
//  XSFoundation
//
//  Created by 张松松 on 16/8/29.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject


/**
 *  格式化输出数据的大小
 *
 *  @param size 数据大小，NSData.length
 *
 *  @return 格式化字符串
 */
+ (NSString *)formatDataSize:(double)size;
+ (NSString *)formatDataSizeByCalculate:(double)size;
+ (NSString *)formatDataSizeIniOS:(double)size;

@end
