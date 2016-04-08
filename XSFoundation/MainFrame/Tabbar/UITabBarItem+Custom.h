//
//  UITabBarItem+Custom.h
//  Tenement
//
//  Created by 张松松 on 15/7/23.
//  Copyright (c) 2015年 CJia Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (Custom)

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                       custom:(BOOL)isCustom;

@end
