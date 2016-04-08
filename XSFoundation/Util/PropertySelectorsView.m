//
//  PropertySelectorsView.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/17.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "PropertySelectorsView.h"
#import "PropertySelector.h"

#define kSelectorTag 5670

@interface PropertySelectorsView()

@end

@implementation PropertySelectorsView

- (PropertySelectorsView *)initWithSelectors:(NSArray<SimpleModel *> *)data;
{
    self = [super init];
    if (self)
    {
        self.results = [NSMutableArray arrayWithCapacity:data.count];
        CGFloat y = CGPointZero.y;
        for (NSInteger i = 0; i < data.count; i++)
        {
            SimpleModel *model = [data objectAtIndex:i];
            PropertySelector *selector = [[PropertySelector alloc] initWithFrame:CGRectMake(CGPointZero.x, y, SCREEN_SIZE.width, kPropertySelectorHeight)];
            selector.titleLabel.text = model.title;
            selector.titles = model.data;
            [selector.propertySeg addTarget:self action:@selector(propertyChange:) forControlEvents:UIControlEventValueChanged];
            selector.tag = kSelectorTag + i;
            [selector setUp];
            [self addSubview:selector];
            y += selector.frame.size.height;
            y += COMMON_VI_10 / 2;
            [self.results addObject:[(NSArray *)model.data firstObject]];
        }
        self.frame = CGRectMake(CGPointZero.x, CGPointZero.y, SCREEN_SIZE.width, y);
    }
    return self;
}

//- (NSArray<SimpleModel *> *)results
//{
//    NSMutableArray<SimpleModel *> *results = [NSMutableArray array];
//    for (NSInteger i = 0; i < self.subviews.count; i ++)
//    {
//        UIView *subView = [self.subviews objectAtIndex:i];
//        if ([subView isKindOfClass:[PropertySelector class]])
//        {
//            PropertySelector *selector = (PropertySelector *)subView;
//            [results addObject:selector.result];
//        }
//    }
//    return results;
//}

- (void)propertyChange:(id)sender
{
    PropertySelector *selector = (id)[sender superview];
    NSInteger index = selector.tag - kSelectorTag;
    NSLog(@"%@%@---%@",selector.titleLabel.text,selector.result.title,selector.result.data);
    [self.results replaceObjectAtIndex:index withObject:selector.result];
    NSArray *array = [NSArray arrayWithArray:self.results];
    if (self.selectorResult) {
        self.selectorResult(index,array);
    }
}

@end
