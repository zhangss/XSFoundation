//
//  UIColor+Extern.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIColor的拓展
 *  1.RGBA色
 *  2.十六进制色
 */

@interface UIColor (Extern)

#pragma mark -
#pragma mark RGB Color

/**
 *  RGB色
 *
 *  @param R red,0-255
 *  @param G green,0-255
 *  @param B blue,0-255
 *
 *  @return
 */
#define COLOR_RGB(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

/**
 *  RGBA色
 *
 *  @param R red,0-255
 *  @param G green,0-255
 *  @param B blue,0-255
 *  @param A alpha,0-1
 *
 *  @return
 */
#define COLOR_RGBA(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]

/**
 *  获取颜色模式
 *
 *  @return
 */
- (CGColorSpaceModel)colorSpaceModel;

/**
 *  获取RED值
 *
 *  @return
 */
- (CGFloat)red;

/**
 *  获取GREEN值
 *
 *  @return
 */
- (CGFloat)green;

/**
 *  获取BLUE值
 *
 *  @return
 */
- (CGFloat)blue;

/**
 *  获取Alpha值
 *
 *  @return 
 */
- (CGFloat)alpha;

#pragma mark -
#pragma mark HEX Color
/**
 *  十六进制HEX(Hexadecimal [.heksə'desɪm(ə)l])色
 *
 *  @param hexColor 十六进制字符串
 *         字符串分三种样式：@"#123456"、 @"0X123456"、 @"123456"
 *         不符合规则则返回Clear Color
 *
 *  @return
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColor;

/**
 *  十六进制HEX色
 *
 *  @param hexColor 十六进制字符串
 *  @param alpha    透明度
 *
 *  @return
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColor
                          alpha:(CGFloat)alpha;

#pragma mark -
#pragma mark Image Color
/**
 *  Image转换为Color
 */
#define COLOR_IMAGE(image) [UIColor colorWithPatternImage:image]


@end
