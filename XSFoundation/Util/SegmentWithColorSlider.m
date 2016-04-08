//
//  SegmentWithColorSlider.m
//  Mongo
//
//  Created by SAIC_Zhangss on 14/12/31.
//  Copyright (c) 2014年 com.yisheng. All rights reserved.
//

#import "SegmentWithColorSlider.h"

@interface SegmentWithColorSlider ()

@property (nonatomic, strong) CALayer *indicatorLayer;
@property (nonatomic, assign) CGFloat segmentWidth;
@property (nonatomic, assign) CGFloat segmentHeight;

@end

@implementation SegmentWithColorSlider

- (id)initWithFrame:(CGRect)frame
             titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titles = titles;
        self.segmentHeight = frame.size.height;
        self.segmentWidth = frame.size.width / titles.count;
        [self setUpDefault];
    }
    return self;
}

- (void)setUpDefault
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = 0;
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.indicatorHeight = 5.0f;
    self.indicatorWidth = self.segmentWidth - COMMON_VI_10 * 2;
    self.segmentMode = SegmentModeAverage;
    self.indicatorLayer = [CALayer layer];
}

- (void)drawRect:(CGRect)rect
{
    [self.backgroundColor set];
    UIRectFill([self bounds]);
    
    [self.titles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
        
        if (idx == _selectedIndex)
        {
            [self.indicatorColor set];
        }
        else
        {
            [self.textColor set];
        }
        CGFloat stringHeight = [titleString sizeWithFont:self.font].height;
        CGFloat y = (self.segmentHeight - stringHeight) / 2;
        CGRect rect = CGRectMake(self.segmentWidth * idx, y, self.segmentWidth, stringHeight);
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        [titleString drawInRect:rect
                       withFont:self.font
                  lineBreakMode:UILineBreakModeClip
                      alignment:UITextAlignmentCenter];
#else
        [titleString drawInRect:rect
                       withFont:self.font
                  lineBreakMode:NSLineBreakByClipping
                      alignment:NSTextAlignmentCenter];
#endif
    }];
    
    [self drawBottonLine];
    
    self.indicatorLayer.frame = [self frameForSelectionIndicator];
    self.indicatorLayer.backgroundColor = self.indicatorColor.CGColor;
    [self.layer addSublayer:self.indicatorLayer];
}

- (void)drawBottonLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, .5f);
    [[UIColor blackColor] setStroke];
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, self.bounds.size.height - 0.5);
    CGContextAddLineToPoint(context, SCREEN_SIZE.width, self.bounds.size.height - 0.5);
    CGContextStrokePath(context);
}

- (CGRect)frameForSelectionIndicator
{
    CGFloat stringWidth = [[self.titles objectAtIndex:self.selectedIndex] sizeWithFont:self.font].width;
    
    if (self.segmentMode == SegmentModeFitTitle)
    {
        CGFloat widthTillEndOfSelectedIndex = (self.segmentWidth * self.selectedIndex) + self.segmentWidth;
        CGFloat widthTillBeforeSelectedIndex = (self.segmentWidth * self.selectedIndex);
        
        CGFloat x = ((widthTillEndOfSelectedIndex - widthTillBeforeSelectedIndex) / 2) + (widthTillBeforeSelectedIndex - stringWidth / 2);
        return CGRectMake(x, _indicatorPositionY, stringWidth, self.indicatorHeight);
    }
    else
    {
        CGFloat indicatorX = (self.segmentWidth - self.indicatorWidth)/2 + (self.segmentWidth * self.selectedIndex);
        return CGRectMake(indicatorX, _indicatorPositionY, self.indicatorWidth, self.indicatorHeight);
    }
}

- (void)updateSegmentsRects
{
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    if (CGRectIsEmpty(self.frame))
    {
        self.segmentWidth = 0;
        for (NSString *titleString in _titles)
        {
            CGFloat stringWidth = [titleString sizeWithAttributes:[UIUtil attributesWithColor:[UIColor clearColor] font:self.font]].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
        }
        
        self.bounds = CGRectMake(0, 0, self.segmentWidth * self.titles.count, self.segmentHeight);
    }
    else
    {
        self.segmentWidth = self.frame.size.width / self.titles.count;
        self.segmentHeight = self.frame.size.height;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    [self updateSegmentsRects];
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = touchLocation.x / self.segmentWidth;
        
        if (segment != self.selectedIndex) {
            [self setSelectedIndex:segment animated:YES];
        }
    }
}

#pragma mark -
- (void)setSelectedIndex:(NSInteger)index
{
    [self setSelectedIndex:index animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated
{
    _selectedIndex = index;
    
    if (animated)
    {
        // Restore CALayer animations
        self.indicatorLayer.actions = nil;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.15f];
        [CATransaction setCompletionBlock:^{
            if (self.superview)
            {
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
        }];
        self.indicatorLayer.frame = [self frameForSelectionIndicator];
        [CATransaction commit];
        [self setNeedsDisplay];
    }
    else
    {
        // Disable CALayer animations
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
        self.indicatorLayer.actions = newActions;
        self.indicatorLayer.frame = [self frameForSelectionIndicator];
        if (self.superview)
        {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.titles)
    {
        [self updateSegmentsRects];
    }
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    if (self.titles)
    {
        [self updateSegmentsRects];
    }
    [self setNeedsDisplay];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (self.titles)
    {
        [self updateSegmentsRects];
    }
    [self setNeedsDisplay];
}

@end
