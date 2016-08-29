//
//  Algorithm.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/22.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Algorithm : NSObject

/**
 *  两个矩形，是否相交
 *
 *  @param aRectangle
 *  @param bRectangle
 *
 *  @return 
 */
+ (BOOL)isRectangle:(CGRect)aRectangle
crossingWithRectangle:(CGRect)bRectangle;

@end
