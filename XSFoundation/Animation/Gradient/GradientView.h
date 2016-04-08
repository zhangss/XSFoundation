//
//  GradientView.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/17.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  背景渐变色，三种实现方法 Gradient['ɡreɪdiənt]梯度、渐变色
 *    http://blog.csdn.net/lgouc/article/details/47254839
 *  1.CAGradientLayer:坐标系，(0,0)在左上角
 *    http://www.cnblogs.com/YouXianMing/p/3793913.html
 *  2.CGGradientRef:坐标系，(0,0)在左上角
 *  3.CoreImage:坐标系，(0,0)在左下角
 */

/**
 *  三种渐变方式
 */
typedef NS_ENUM(NSInteger, GradientType) {
    /**
     *  Linear线性的、直线的
     */
    kGradientLinear = 0,
    /**
     *  Radial['reɪdiəl]辐射式、射线、径向
     */
    kGradientRadial = 1,
    /**
     *  Axial['æksiəl]轴线的、轴向
     */
    kGradientAxial = 2
};

/**
 *  三种实现方式
 */
typedef NS_ENUM(NSInteger, GradientIMPType) {
    /**
     *  CAGradientLayer
     */
    kGradientIMPCALayer = 0,
    /**
     *  CGGradientRef
     */
    kGradientIMPCGGradientRef = 1,
    /**
     *  CGShadingRef
     */
    kGradientIMPCGShadingRef = 2,
    /**
     *  CoreImage
     */
    kGradientIMPCoreImage = 3
};

@interface GradientView : UIView

/**
 *  渐变颜色数组
 *  CGColorRef
 */
@property (nonatomic, strong) NSArray *colors;

/**
 *  渐变点
 *  0~1,递增
 */
@property (nonatomic, strong) NSArray<NSNumber *> *locations;

/**
 *  起始位置
 */
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;

/**
 *  渐变色实现类型切换
 */
@property (nonatomic, assign) GradientIMPType impType;

/**
 *  渐变色渐变类型切换
 */
@property (nonatomic, assign) GradientType type;

/**
 *  渐变色范围调整
 *
 *  @param rangeType
 */
- (void)gradientRange:(NSInteger)rangeType;

/**
 *  显示渐变色的动画效果
 */
- (void)showAnimation;

@end
