//
//  UIUtil.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+Extern.h"

#define COMMON_VI_10 10.0f
#define SCREEN_SIZE           [[UIScreen mainScreen] bounds].size
#define VIEW_HEIGHT           ([[UIScreen mainScreen] bounds].size.height - 64)
#define Color_Navi            [UIColor colorWithHexString:@"20a3ff"]
#define Color_BG              [UIColor colorWithHexString:@"f3f5f7"]
#define Color_Main_Title      [UIColor colorWithHexString:@"333333"]
#define Font_Main_Title       [UIFont systemFontOfSize:16]
#define Color_Sub_Title       [UIColor colorWithHexString:@"999999"]
#define Font_Sub_Title        [UIFont systemFontOfSize:12]

#define IntegerToString(i) [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:i]]
#define DEFAULT_STRING(x,y) (x&&x.length>0) ? x : y
#define DEFAULT_NUMBER(x,y) (x) ? x : [NSNumber numberWithInt:y]

#include <math.h>
static inline double radians (double degrees) {return degrees * M_PI/180;}

@interface UIUtil : NSObject

/**
 *  返回样式字典
 *
 *  @param color 颜色
 *  @param font  字体
 *
 *  @return dic
 */
+ (NSDictionary *)attributesWithColor:(UIColor *)color
                                 font:(UIFont *)font;

@end
