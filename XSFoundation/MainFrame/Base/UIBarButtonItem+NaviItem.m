//
//  UIBarButtonItem+NaviItem.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "UIBarButtonItem+NaviItem.h"

@implementation UIBarButtonItem (NaviItem)

+ (UIBarButtonItem *)itemWidth:(CGFloat)width
                         image:(UIImage *)image
                imageHighlight:(UIImage *)imageHighlight
                         title:(NSString *)title
                    titleColor:(UIColor *)titleColor
                        target:(id)target
                        action:(SEL)action
                        offset:(CGPoint)offset
{
    CGRect rect = CGRectMake(0, 0, width, 44);
    UIButton *background_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    background_btn.frame = rect;
    background_btn.backgroundColor = [UIColor clearColor];
    
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.userInteractionEnabled = NO;
    rect.origin.x += offset.x;
    rect.origin.y += offset.y;
    _btn.backgroundColor = [UIColor clearColor];
    _btn.frame = rect;
    
    if (!image) {
        [_btn setBackgroundColor:[UIColor clearColor]];
    } else {
        [_btn setImage:image forState:UIControlStateNormal];
        [_btn setImage:imageHighlight forState:UIControlStateHighlighted];
    }
    
    [background_btn addSubview:_btn];
    
    if (title) {
        [_btn setTitle:title forState:UIControlStateNormal];
        [_btn setTitle:title forState:UIControlStateHighlighted];
        [_btn setTitleColor:titleColor forState:UIControlStateNormal];
        [_btn setTitleColor:titleColor forState:UIControlStateHighlighted];
        [_btn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateDisabled];
        _btn.titleEdgeInsets = UIEdgeInsetsMake(3, 0, 0, 0);
    }
    
    if (target && action) {
        [background_btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return [[UIBarButtonItem alloc] initWithCustomView:background_btn];
}

@end
