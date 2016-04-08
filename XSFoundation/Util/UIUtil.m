//
//  UIUtil.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "UIUtil.h"

@implementation UIUtil

/**
 *  返回样式字典
 *
 *  @param color 颜色
 *  @param font  字体
 *
 *  @return dic
 */
+ (NSDictionary *)attributesWithColor:(UIColor *)color
                                 font:(UIFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                color,NSForegroundColorAttributeName,
                                font,NSFontAttributeName,
                                nil];
    return attributes;
}

@end
