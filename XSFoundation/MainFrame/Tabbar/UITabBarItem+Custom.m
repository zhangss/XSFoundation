//
//  UITabBarItem+Custom.m
//  Tenement
//
//  Created by 张松松 on 15/7/23.
//  Copyright (c) 2015年 CJia Ltd. All rights reserved.
//

#import "UITabBarItem+Custom.h"
#import "UIUtil.h"
#import "UIColor+Extern.h"

@implementation UITabBarItem (Custom)

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                       custom:(BOOL)isCustom
{
    UITabBarItem *item = [self initWithTitle:title image:image selectedImage:selectedImage];
    [item setTitleTextAttributes:[UIUtil attributesWithColor:[UIColor colorWithHexString:@"90979c"] font:[UIFont systemFontOfSize:10]] forState:UIControlStateNormal];
    [item setTitleTextAttributes:[UIUtil attributesWithColor:Color_Navi font:[UIFont boldSystemFontOfSize:10]] forState:UIControlStateSelected];
    [item setTitlePositionAdjustment:UIOffsetMake(0, -COMMON_VI_10/3)];
    return item;
}

@end
