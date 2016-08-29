//
//  Algorithm.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/22.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm

+ (BOOL)isRectangle:(CGRect)aRectangle crossingWithRectangle:(CGRect)bRectangle
{
    CGPoint pointA = aRectangle.origin;
    CGPoint pointB = CGPointMake(aRectangle.origin.x, aRectangle.origin.y + aRectangle.size.height);
    CGPoint pointC = CGPointMake(aRectangle.origin.y, aRectangle.origin.x + aRectangle.size.width);
    CGPoint pointD = CGPointMake(aRectangle.origin.x + aRectangle.size.height, aRectangle.origin.y + aRectangle.size.height);
    return NO;
}

+ (BOOL)isPoint:(CGPoint)point inRectangle:(CGRect)rect
{
    
    return NO;
}

@end
