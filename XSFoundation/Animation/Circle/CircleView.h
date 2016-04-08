//
//  CircleView.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

/**
 *  圆弧起始角度
 */
@property (nonatomic, assign) CGFloat startAngle;
/**
 *  圆弧结束角度
 */
@property (nonatomic, assign) CGFloat endAngle;
/**
 *  圆弧半径
 */
@property (nonatomic, assign) CGFloat radius;
/**
 *  圆弧圆心
 */
@property (nonatomic, assign) CGPoint circleCenter;
/**
 *  圆弧边线宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;
/**
 *  进度值:0~1
 */
@property (nonatomic, assign) CGFloat percent;
/**
 *  是否显示进度
 */
@property (nonatomic, assign) BOOL progress;


/**
 *  全圆
 */
- (void)originalCircle;

/**
 *  半圆
 */
- (void)halfCircle;

/**
 *  进度以及动画
 *
 *  @param percent  进度值
 *  @param animated 是否动画
 */
- (void)setPercent:(CGFloat)percent;

@end
