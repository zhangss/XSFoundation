//
//  CircleView.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "CircleView.h"
#import "UIColor+Extern.h"

@interface CircleView ()
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *times;

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CALayer *gradientLayer;
@property (nonatomic, strong) CALayer *indicatorLayer;
@property (nonatomic, strong) CAShapeLayer *indicatorBGLayer;

@end

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self originalCircle];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //渐变色背景
    [self setBGGradientLayer];
    //设置圆弧边框线
    [self setCircleBorderLayer];
    //设置圆弧背景色
    [self setCircleBGLayer];
    
    if (self.progress)
    {
        [self getProgressLayer];
    }
    else
    {
//        [self.gradientLayer removeFromSuperlayer];
//        self.gradientLayer = nil;
//        [self.progressLayer removeFromSuperlayer];
//        self.progressLayer = nil;
//        [self drawCircleLineAnimation:self.circleLayer];
    }
    
//    [self.layer insertSublayer:self.circleLayer below:self.gradientLayer];
}

- (void)drawCircleLineAnimation:(CALayer *)layer
{
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = 1;
    bas.delegate = self;
    bas.fromValue = [NSNumber numberWithInteger:0];
    bas.toValue = [NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}

/**
 *  边线画圆，路径
 */
- (void)circlePath
{
    self.path = nil;
    self.path = [UIBezierPath bezierPath];
    [self.path addArcWithCenter:self.circleCenter
                         radius:self.radius
                     startAngle:self.startAngle
                       endAngle:self.endAngle
                      clockwise:NO];
}

#pragma mark -
#pragma mark Interface
- (void)originalCircle
{
    self.radius = self.frame.size.width / 2 - COMMON_VI_10;
    self.startAngle = 0.0f;
    self.endAngle = 2 * M_PI;
    self.circleCenter = CGPointMake(self.frame.size.width / 2,
                                    self.frame.size.height / 2);
    self.lineWidth = 3.0f;
    self.progress = NO;
    
    [self circlePath];
    
    /**
     *  重新调用drawRect重绘
     */
    [self setNeedsDisplay];
}

- (void)halfCircle
{
    self.radius = self.frame.size.height / 2 - COMMON_VI_10 * 4;
    self.startAngle = M_PI / 2;
    self.endAngle = M_PI * 3 / 2;
    self.circleCenter = CGPointMake(CGPointZero.x,
                                    self.frame.size.height / 2);
    self.lineWidth = 10.0f;
    self.progress = NO;
    [self circlePath];
    
    self.progress = YES;
    
    /**
     *  进度条 渐变色范围以及渐变点
     */
    self.colors = [NSArray arrayWithObjects:
                   (id)[[UIColor colorWithHexString:@"fea45d"] CGColor],
                   (id)[[UIColor colorWithHexString:@"55d6b9"] CGColor],
                   (id)[[UIColor colorWithHexString:@"7287e9"] CGColor],
                   (id)[[UIColor colorWithHexString:@"1339e9"] CGColor],
                   nil];
    self.times = @[@(0.0f),@(0.3f),@(0.6f),@(1)];

    [self setNeedsDisplay];
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    
    [self progressAnimation];
}

#pragma mark -
#pragma mark Common
#pragma mark - Gradient Background Color
- (void)setBGGradientLayer
{
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    //设定颜色组
    [gradientLayer setColors:[NSArray arrayWithObjects:
                              (id)[[UIColor colorWithHexString:@"f47c40"] CGColor],//右上颜色
                              (id)[[UIColor colorWithHexString:@"f54a48"] CGColor],//左下颜色
                              nil]];
    [gradientLayer setStartPoint:CGPointMake(1, 0)];
    [gradientLayer setEndPoint:CGPointMake(0, 1)];
    [gradientLayer setLocations:@[@(0.0f),@(1)]];
    [self.layer addSublayer:gradientLayer];
}

- (void)setCircleBorderLayer
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:self.circleCenter
                          radius:self.radius + self.lineWidth / 2
                      startAngle:self.startAngle
                        endAngle:self.endAngle
                       clockwise:NO];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.fillColor = [[UIColor clearColor] CGColor];
    borderLayer.strokeColor = [[UIColor whiteColor] CGColor];
    borderLayer.lineWidth = 1.0f;
    borderLayer.path = [circlePath CGPath];
    borderLayer.frame = self.bounds;
    [self.layer addSublayer:borderLayer];
}

- (void)setCircleBGLayer
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:self.circleCenter
                          radius:self.radius
                      startAngle:self.startAngle
                        endAngle:self.endAngle
                       clockwise:NO];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.fillColor = [[UIColor clearColor] CGColor];
    borderLayer.strokeColor = [[UIColor colorWithHexString:@"961616" alpha:.1f] CGColor];
    borderLayer.lineWidth = self.lineWidth - 1;
    borderLayer.path = [circlePath CGPath];
    //最后设置Frame
    borderLayer.frame = self.bounds;
    [self.layer addSublayer:borderLayer];
}

#pragma mark -
#pragma mark Color Progress
/**
 *  GAGradientLayer 
 *
 *  @return 渐变色Layer
 */
- (CAGradientLayer *)getGradientLayer
{
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:self.colors];
    [gradientLayer setStartPoint:CGPointMake(0, 1)];
    [gradientLayer setEndPoint:CGPointMake(0, 0)];
    [gradientLayer setLocations:self.times];
    return gradientLayer;
}

- (void)getProgressLayer
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:self.circleCenter
                          radius:self.radius
                      startAngle:self.startAngle
                        endAngle:self.endAngle
                       clockwise:NO];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [[UIColor blueColor] CGColor];
    //进度线截面为圆形
//    _progressLayer.lineCap = kCALineCapRound;
    //进度线截面为直线
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.lineWidth = self.lineWidth;
    _progressLayer.path = [circlePath CGPath];
    _progressLayer.strokeEnd = 0;
    
    self.gradientLayer = [CALayer layer];
    [self.gradientLayer addSublayer:[self getGradientLayer]];
    
    [self.gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:self.gradientLayer];
    
    [self setIndicatorLayer];
}

#pragma mark -
#pragma mark Indicator
- (CGPoint)indicatorCenter
{
    CGPoint center = CGPointMake(COMMON_VI_10 * 2, self.circleCenter.y);
    CGFloat value = 0.0 * M_PI;
    CGFloat radius = self.radius + COMMON_VI_10 * 2;
    center.x = radius * sin(value);
    center.y = radius + radius * cos(value);
    return center;
}

- (CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

- (CAKeyframeAnimation *)colorGradient_Animation:(float)time
{
    //创建动画
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
    //动画时间
    [keyFrame setDuration:time];
    //改变的内容
//    NSArray *allColor = [NSArray arrayWithObjects:
//                         (id)[[UIColor colorWithHexString:@"fea45d"] CGColor],
//                         (id)[[UIColor colorWithHexString:@"55d6b9"] CGColor],
//                         (id)[[UIColor colorWithHexString:@"7287e9"] CGColor],
//                         (id)[[UIColor colorWithHexString:@"1339e9"] CGColor],
//                         (id)[[UIColor colorWithHexString:@"1339e9"] CGColor],
//                         nil];
    keyFrame.values = [self getGradientProgressColors];
    //改点的时间点0~1递增
//    NSArray *allTimes = @[@(0.0f),@(0.5f),@(1)];
//    keyFrame.keyTimes = allTimes;
    [keyFrame setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    keyFrame.removedOnCompletion = NO;
    keyFrame.fillMode = kCAFillModeForwards;
    return keyFrame;
}

//- (UIColor *)colorOfPoint:(CGPoint)point {
//    unsigned char pixel[4] = {0};
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
//    
//    CGContextTranslateCTM(context, -point.x, -point.y);
//    
//    [self.layer renderInContext:context];
//    
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    
//    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
//    
//    return color;
//}

- (NSArray *)getGradientProgressColors
{
    //获取当前进度
    //区间大小
    CGFloat averge = 1.0 / (self.colors.count - 1);
    //进度 占有的区间个数
    NSInteger count = self.percent / averge;
    //进度 占有的区间色区
    NSMutableArray *progressColors =[NSMutableArray arrayWithArray:[self.colors subarrayWithRange:NSMakeRange(0, MIN(self.colors.count, count + 1))]];
    
    //开始色
    UIColor *startColor = [UIColor colorWithCGColor:(CGColorRef)[self.colors objectAtIndex:MAX(0, count-1)]];
    //结束色
    UIColor *endColor = [UIColor colorWithCGColor:(CGColorRef)[self.colors objectAtIndex:MIN(self.colors.count - 1, count + 1)]];
    
    //最终进度颜色
    UIColor *progressColor;
    CGFloat R = (startColor.red + (endColor.red - startColor.red)*(self.percent /averge - count))*255.0;
    CGFloat G = (startColor.green + (endColor.green - startColor.green)*(self.percent/averge - count))*255.0;
    CGFloat B = (startColor.blue + (endColor.blue - startColor.blue)*(self.percent/averge - count))*255.0;
    progressColor = COLOR_RGB(R, G, B);
    NSLog(@"Start: R:%f G:%f B:%f",startColor.red,startColor.green,startColor.blue);
    NSLog(@"End: R:%f G:%f B:%f",endColor.red,endColor.green,endColor.blue);
    NSLog(@"Progress: R:%f G:%f B:%f",R/255.0,G/255.0,B/255.0);
    [progressColors insertObject:(id)progressColor.CGColor atIndex:MIN(self.colors.count, count + 1)];
    return progressColors;
}

- (void)setIndicatorLayer
{
    CGFloat indicatorInterval = 4.0f;
    self.indicatorLayer = [CALayer layer];
    UIBezierPath *indicatorAlphaPath = [UIBezierPath bezierPath];
    [indicatorAlphaPath addArcWithCenter:[self indicatorCenter]
                               radius:self.lineWidth * 2
                           startAngle:0.0
                             endAngle:2 * M_PI
                            clockwise:NO];
    CAShapeLayer *indicatorAlphaLayer = [CAShapeLayer layer];
    indicatorAlphaLayer.fillColor = [[UIColor colorWithHexString:@"FFFFFF" alpha:0.4f] CGColor];
    indicatorAlphaLayer.strokeColor = [[UIColor clearColor] CGColor];
    indicatorAlphaLayer.path = [indicatorAlphaPath CGPath];
    indicatorAlphaLayer.frame = CGRectMake(0, 0, self.lineWidth * 2, self.lineWidth * 2);
    [indicatorAlphaLayer addAnimation:[self opacityForever_Animation:1.0f] forKey:nil];
    [self.indicatorLayer addSublayer:indicatorAlphaLayer];
    
    UIBezierPath *indicatorBGPath = [UIBezierPath bezierPath];
    [indicatorBGPath addArcWithCenter:[self indicatorCenter]
                               radius:self.lineWidth * 2 - indicatorInterval
                           startAngle:0.0
                             endAngle:2 * M_PI
                            clockwise:NO];
    _indicatorBGLayer = [CAShapeLayer layer];
    _indicatorBGLayer.fillColor = [[UIColor colorWithHexString:@"fea45d"] CGColor];
    _indicatorBGLayer.strokeColor = [[UIColor clearColor] CGColor];
    _indicatorBGLayer.path = [indicatorBGPath CGPath];
    _indicatorBGLayer.frame = CGRectMake(0, 0, self.lineWidth * 2 - indicatorInterval, self.lineWidth * 2 - indicatorInterval);
    [self.indicatorLayer addSublayer:_indicatorBGLayer];
    
    UIBezierPath *whiteCirclePath = [UIBezierPath bezierPath];
    [whiteCirclePath addArcWithCenter:[self indicatorCenter]
                          radius:self.lineWidth * 2 - indicatorInterval * 2 - 1
                           startAngle:0.0
                             endAngle:2 * M_PI
                       clockwise:NO];
    CAShapeLayer *indicatorWhiteCircleLayer = [CAShapeLayer layer];
    indicatorWhiteCircleLayer.fillColor = [[UIColor clearColor] CGColor];
    indicatorWhiteCircleLayer.strokeColor = [[UIColor whiteColor] CGColor];
    indicatorWhiteCircleLayer.lineWidth = indicatorInterval - 1;
    indicatorWhiteCircleLayer.path = [whiteCirclePath CGPath];
    indicatorWhiteCircleLayer.frame = CGRectMake(0, 0, self.lineWidth * 2 - 2 * indicatorInterval, self.lineWidth * 2 - 2 * indicatorInterval);
    [self.indicatorLayer addSublayer:indicatorWhiteCircleLayer];
    [self.layer addSublayer:self.indicatorLayer];
}

- (void)progressAnimation
{
    /**
     *  Progress Animate
     */
    [CATransaction begin];
//    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:3.0f];
    _progressLayer.strokeEnd = self.percent;
    [CATransaction commit];
    
    /**
     *  Indicator Animate
     */
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGFloat start = M_PI_2;
    CGFloat end = start - self.percent * M_PI;
    CGPathAddArc(circlePath, NULL, self.circleCenter.x, - self.circleCenter.y + COMMON_VI_10 * 4, self.radius, start, end, YES);
    //关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置path属性
    [animation setPath:circlePath];
    CFRelease(circlePath);
    [animation setDuration:3.0f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    //这句代码表示 是否动画回到原位
//    [animation setAutoreverses:NO];
    animation.calculationMode = kCAAnimationCubicPaced;
//    animation.rotationMode = kCAAnimationRotateAuto;
    // 1.2保存执行完之后的状态
    // 1.2.1执行完之后不删除动画
    animation.removedOnCompletion = NO;
    // 1.2.2执行完之后保存最新的状态
    animation.fillMode = kCAFillModeForwards;
    [self.indicatorLayer addAnimation:animation forKey:NULL];

    [_indicatorBGLayer addAnimation:[self colorGradient_Animation:3.0f] forKey:nil];
}

@end
