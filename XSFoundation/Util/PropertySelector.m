//
//  PropertySelector.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/17.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "PropertySelector.h"

@implementation PropertySelector

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        frame.size.height = kPropertySelectorHeight;
        CGFloat x = COMMON_VI_10;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGPointZero.y, 80, frame.size.height)];
        self.titleLabel.font = Font_Sub_Title;
        self.titleLabel.textColor = Color_Main_Title;
        [self addSubview:_titleLabel];
        x += self.titleLabel.frame.size.width;
        
        self.propertySeg = [[UISegmentedControl alloc] initWithFrame:CGRectMake(x, CGPointZero.y, frame.size.width - x - COMMON_VI_10, frame.size.height)];
        self.propertySeg.apportionsSegmentWidthsByContent = YES;
        [self addSubview:self.propertySeg];
    }
    return self;
}

- (void)setUp
{
    [self.titleLabel sizeToFit];
    CGRect frame = self.titleLabel.frame;
    frame.origin.x = CGPointZero.x;
    frame.size.height = kPropertySelectorHeight;
    self.titleLabel.frame = frame;
    
    frame = self.propertySeg.frame;
    frame.origin.x = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width;
    frame.size.width = self.bounds.size.width - frame.origin.x;
    self.propertySeg.frame = frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    for (NSInteger i = 0; i < titles.count; i++)
    {
        SimpleModel *model = [titles objectAtIndex:i];
        [self.propertySeg insertSegmentWithTitle:model.title atIndex:i animated:YES];
        self.propertySeg.selectedSegmentIndex = 0;
//        [self.propertySeg setTitle:model.title forSegmentAtIndex:i];
    }
}

- (SimpleModel *)result
{
    SimpleModel *resultModel = nil;
    if (self.propertySeg.selectedSegmentIndex == UISegmentedControlNoSegment)
    {
        resultModel = [self.titles objectAtIndex:0];
    }
    else
    {
        resultModel = [self.titles objectAtIndex:self.propertySeg.selectedSegmentIndex];
    }
    return resultModel;
}

@end
