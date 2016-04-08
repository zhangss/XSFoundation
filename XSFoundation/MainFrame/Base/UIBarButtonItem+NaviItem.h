//
//  UIBarButtonItem+NaviItem.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NaviItem)

+ (UIBarButtonItem *)itemWidth:(CGFloat)width
                         image:(UIImage *)image
                imageHighlight:(UIImage *)imageHighlight
                         title:(NSString *)title
                    titleColor:(UIColor *)titleColor
                        target:(id)target
                        action:(SEL)action
                        offset:(CGPoint)offset;

@end
