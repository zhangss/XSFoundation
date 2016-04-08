//
//  SegmentWithColorSlider.h
//  Mongo
//
//  Created by SAIC_Zhangss on 14/12/31.
//  Copyright (c) 2014年 com.yisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 */
typedef NS_ENUM(NSInteger, SegmentMode)
{
    /**
     *  分段控制器均分
     */
    SegmentModeAverage = 0,
    /**
     *  分段控制器按Title适配
     */
    SegmentModeFitTitle = 1
};

@interface SegmentWithColorSlider : UIControl

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) SegmentMode segmentMode;    //默认平均
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat indicatorHeight;    //默认5.0
@property (nonatomic, assign) CGFloat indicatorWidth;    //默认SegmentWidht-20
@property (nonatomic, assign) UIEdgeInsets segmentEdgeInset;
@property (nonatomic, assign) CGFloat indicatorPositionY;    //标志的位置

- (id)initWithFrame:(CGRect)frame
             titles:(NSArray *)titles;

@end
