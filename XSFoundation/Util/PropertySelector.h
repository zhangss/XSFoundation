//
//  PropertySelector.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/17.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleModel.h"

#define kPropertySelectorHeight 30.0f

@interface PropertySelector : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISegmentedControl *propertySeg;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) SimpleModel *result;

- (void)setUp;

@end
