//
//  QuartZView.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  QuartZ画图
 *  http://southpeak.github.io/blog/2014/11/10/quartz-2dbian-cheng-zhi-nan-zhi-%5B%3F%5D-:gai-lan/
 *
 *  5中不同类型的Graphics Context
 *  Bitmap、PDF、Window、Layer、Post
 *
 *  12种QuartZ 2D的API包含的数据类型
 *  CGPathRef、CGImageRef、CGLayerRef、CGPatternRef
 *  CGShadingRef、CGGradientRef、
 *  CGFunctionRef、
 *  CGColorRef、CGColorSpaceRef、CGFontRef
 *  CGImageSourceRef、CGImageDestinationRef、
 *  CGPDFDictionaryRef、
 *  CGPDFScannerRef
 *  CGPSConverterRef
 */

@interface QuartZView : UIView

@property (nonatomic, assign) CGLineJoin lineJone;

@property (nonatomic, assign) CGLineCap lineCap;

@property (nonatomic, assign) CGBlendMode blendMode;

@property (nonatomic, assign) CGSize shadowOffSet;
@property (nonatomic, assign) CGFloat blur;
@property (nonatomic, assign) UIColor *shadowColor;

@end
