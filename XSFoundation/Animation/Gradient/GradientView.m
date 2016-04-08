//
//  GradientView.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/17.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "GradientView.h"

@interface GradientView ()

@property (nonatomic, assign) CGRect gradientColorsFrame;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) CAShapeLayer *shapeLayer; //渐变色显示范围

@end

@implementation GradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**
         *  获取比self.bounds缩小10像素的矩形frame
         *
         *  @param self.bounds  参考矩形的位置
         *  @param COMMON_VI_10 水平方向缩小(+)/放大(-)
         *  @param COMMON_VI_10 垂直方向缩小(+)/放大(-)
         *
         *  @return 结果Frame
         */
        self.gradientColorsFrame = CGRectInset(self.bounds,
                                               COMMON_VI_10 * 2,
                                               COMMON_VI_10 * 2);
        
        /**
         *  按照参考矩形的大小位移
         *
         *  @param self.bounds  参考矩形的位置
         *  @param 1 水平方向位移
         *  @param 1 垂直方向位移
         *
         *  @return
         */
        self.gradientColorsFrame = CGRectOffset(self.gradientColorsFrame,
                                                1,
                                                1);
        
        self.colors = [NSArray arrayWithObjects:
                       (id)[UIColor redColor].CGColor,
                       (id)[UIColor blueColor].CGColor,
                       nil];
        self.startPoint = CGPointMake(0, 0);
        self.endPoint = CGPointMake(0, 0);
        self.impType = kGradientIMPCALayer;
        self.type = kGradientLinear;
        
        /**
         *  设置是否透明。默认YES，不透明
         *  使用DrawRect时，设置背景色为clearColor显示为黑色，设置为NO才会透明。
         */
        self.opaque = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/**
 *  使用UIView绘图时的注意事项
 *  1.调用setNeedsDisplay会自动调用drawRect，不推荐直接调用drawRect。
 *  2.调用时机Controller->loadView->viewDidLoad->drawRect
 *  3.如果View不设置Frame,或则Rect大小为0，drawRect则不会被调用
 *  4.刷新drawRect是需要清理上次痕迹，否则效果叠加
 *
 *  1.该方法在调用sizeThatFits后被调用。
 *    所以可以先调用sizeToFit计算出size，然后系统自动调用drawRect:方法。
 *  2.通过设置contentMode属性值为UIViewContentModeRedraw。
 *    在每次设置或更改frame的时候自动调用drawRect:
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [super drawRect:rect];
    //修改背景色1
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rect);
    //修改背景色2
//    [[UIColor redColor] set];
//    UIRectFill([self bounds]);
    
    //坐标系统
    [self drawUIViewCoordinate];
    
    //实现渐变色
    if (self.impType == kGradientIMPCGGradientRef)
    {
        [self setGradientColorWithCGGradientRef];
    }
    if (self.impType == kGradientIMPCGShadingRef)
    {
        [self setGradientColorWithCGShadingRef];
    }
    else if (self.impType == kGradientIMPCoreImage)
    {
        [self setGradientColorWithCoreImage];
    }
    else
    {

    }
}

#warning Layer绘图
//Layer绘图
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx

#pragma mark - Coordinate -
- (void)drawUIViewCoordinate
{
    CGFloat lineWidth = 1.0f;
    CGFloat coordinateHeight = COMMON_VI_10 * 2;
    CGFloat width = self.bounds.size.width - COMMON_VI_10 * 4;         //x坐标轴长度
    CGFloat height = self.bounds.size.height - COMMON_VI_10 * 4;       //y坐标轴长度
    CGFloat scaleHeight = 4.0f;                     //大刻度线高度
    CGFloat halfScaleHeight = scaleHeight / 2;      //小刻度线高度
    CGFloat scaleUnit = 0.5;                        //一个大刻度的单位
    CGFloat halfScaleUnit = 0.1;                    //一个小刻度的单位
    CGSize maxSize = CGSizeMake(1.0f, 1.0f);        //最大值
    CGSize minSize = CGSizeZero;
    CGPoint originalPoint = CGPointMake(COMMON_VI_10 * 2, COMMON_VI_10 * 2);//原点
    
    /**
     *  一个大刻度所占的宽度，为x与y计算出来的宽度的最小值
     */
    CGFloat scaleWidthX = width / ((maxSize.width - minSize.width) / scaleUnit);
    CGFloat scaleWidthY = height / ((maxSize.height - minSize.height) / scaleUnit);
    CGFloat halfScaleWidthX = scaleWidthX * halfScaleUnit / scaleUnit;
    CGFloat halfScaleWidthY = scaleWidthY * halfScaleUnit / scaleUnit;

    /**
     *  计算大刻度线的位置
     */
    NSInteger scaleCountX = (maxSize.width - minSize.width) / scaleUnit;
    NSInteger scaleCountY = (maxSize.height - minSize.height) / scaleUnit;
    NSInteger halfScaleCountX = (maxSize.width - minSize.width) / halfScaleUnit;
    NSInteger halfScaleCountY = (maxSize.height - minSize.height) / halfScaleUnit;
    
    /**
     *  刻度文字相关
     */
    CGFloat textMaxHeight = coordinateHeight - scaleHeight;
    NSDictionary *textAttrs = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                NSBackgroundColorAttributeName: [UIColor clearColor],
                                NSFontAttributeName: [UIFont systemFontOfSize:10]};
    
    //获取当前上下文环境
    CGContextRef context = UIGraphicsGetCurrentContext();
    //保存当前环境，便于以后恢复
    CGContextSaveGState(context);
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path setLineWidth:lineWidth];
//    [path moveToPoint:originalPoint];
//    [path addLineToPoint:CGPointMake(originalPoint.x + width, originalPoint.y)];
//    [[UIColor whiteColor] setFill];
//    [path closePath];
//    [path stroke];
    //x轴
    CGContextMoveToPoint(context, originalPoint.x, originalPoint.y);
    CGContextAddLineToPoint(context, originalPoint.x + width, originalPoint.y);
    //x轴大刻度线
    for (NSInteger i = 0; i <= scaleCountX; i ++)
    {
        CGContextMoveToPoint(context, originalPoint.x + scaleWidthX * i, originalPoint.y);
        CGPoint scaleEndPoint = CGPointMake(originalPoint.x + scaleWidthX * i, originalPoint.y - scaleHeight);
        CGContextAddLineToPoint(context, scaleEndPoint.x, scaleEndPoint.y);
        
//        NSString *scaleString = [NSString stringWithFormat:@"%.1f",scaleUnit * i];
//        CGRect textRect = CGRectZero;
//        textRect.size = [scaleString sizeWithAttributes:textAttrs];
//        textRect.size.height = MIN(textMaxHeight, textRect.size.height);
//        textRect.origin.x = scaleEndPoint.x - textRect.size.width / 2;
//        textRect.origin.y = scaleEndPoint.y - textRect.size.height;
//        [scaleString drawInRect:textRect withAttributes:textAttrs];;
    }
    //x轴小刻度线
    for (NSInteger i = 0; i <= halfScaleCountX; i ++)
    {
        CGContextMoveToPoint(context, originalPoint.x + halfScaleWidthX * i, originalPoint.y);
        CGContextAddLineToPoint(context, originalPoint.x + halfScaleWidthX * i, originalPoint.y - halfScaleHeight);
    }
    //y轴
    CGContextMoveToPoint(context, originalPoint.x, originalPoint.y);
    CGContextAddLineToPoint(context, originalPoint.x, originalPoint.y + height);
    //y轴大刻度线
    for (NSInteger i = 0; i <= scaleCountY; i ++)
    {
        CGContextMoveToPoint(context, originalPoint.x, originalPoint.y + scaleWidthY * i);
        CGPoint scaleEndPoint = CGPointMake(originalPoint.x - scaleHeight, originalPoint.y + scaleWidthY * i);
        CGContextAddLineToPoint(context, scaleEndPoint.x, scaleEndPoint.y);
        
//        NSString *scaleString = [NSString stringWithFormat:@"%.1f",scaleUnit * i];
//        CGRect textRect = CGRectZero;
//        textRect.size = [scaleString sizeWithAttributes:textAttrs];
//        textRect.size.height = MIN(textMaxHeight, textRect.size.height);
//        textRect.origin.x = scaleEndPoint.x - textRect.size.width;
//        textRect.origin.y = scaleEndPoint.y - textRect.size.height / 2;
//        [scaleString drawInRect:textRect withAttributes:textAttrs];;
    }
    //y轴小刻度线
    for (NSInteger i = 0; i <= halfScaleCountY; i ++)
    {
        CGContextMoveToPoint(context, originalPoint.x, originalPoint.y + halfScaleWidthY * i);
        CGContextAddLineToPoint(context, originalPoint.x - halfScaleHeight, originalPoint.y + halfScaleWidthY * i);
    }
    CGContextClosePath(context);
    CGContextSetLineWidth(context, lineWidth);
    
//http://www.techotopia.com/index.php/An_iOS_7_Graphics_Tutorial_using_Core_Graphics_and_Core_Image
    /**
     *  生成颜色
     */
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGFloat components[] = {0.0, 1.0, 0.0, 1.0}; //[UIColor greenColor]
//    CGColorRef color = CGColorCreate(colorSpace, components);
//    CGContextSetStrokeColorWithColor(context, color);
    
    //Line Dash
//    CGFloat dashArr[] = {2,6,4,2};
//    CGContextSetLineDash(context, 3, dashArr, 4);
    
    //Shadow
//    CGSize shadowOffset = CGSizeMake(-10, 15);
//    CGContextSaveGState(context);
//    CGContextSetShadow(context, shadowOffset, 5);
//    CGContextSetShadowWithColor(context, shadowOffset, 5, [UIColor greenColor].CGColor);
    //画图codeing...
//    CGContextRestoreGState(context);
    
    //1.画矩形
    //2.画椭圆/圆 Ellipse[ɪ'lɪps]
    //3.画圆弧
    //4.Cubic Bézier Curve
    //5.Quadratic Bézier Curve
//    CGContextAddRect(context, self.gradientColorsFrame);
//    CGContextAddEllipseInRect(context, self.gradientColorsFrame);
//    CGContextAddArc(context, 0, 0, 100, M_PI_4, M_PI_2, NO);
//    CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400);
//    CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200);
    
//    CGContextStrokePath(context);
//    CGColorSpaceRelease(colorSpace);
//    CGColorRelease(color);
    

    //设置填充色
//    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    //填充
//    CGContextFillRect(context, self.gradientColorsFrame)
//    CGContextFillEllipseInRect(context, self.gradientColorsFrame);
//    CGContextFillPath(context); //通用

    [[UIColor greenColor] setStroke];
    [[UIColor whiteColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);

    //刻度值X
    for (NSInteger i = 0; i <= scaleCountX; i ++)
    {
        CGPoint scaleEndPoint = CGPointMake(originalPoint.x + scaleWidthX * i, originalPoint.y - scaleHeight);
        NSString *scaleString = nil;
        scaleString = [NSString stringWithFormat:@"%.1f",scaleUnit * i];
        CGRect textRect = CGRectZero;
        textRect.size = [scaleString sizeWithAttributes:textAttrs];
        textRect.size.height = MIN(textMaxHeight, textRect.size.height);
        textRect.origin.x = scaleEndPoint.x - textRect.size.width / 2;
        textRect.origin.y = scaleEndPoint.y - textRect.size.height;
        [scaleString drawInRect:textRect withAttributes:textAttrs];;
    }
    
    //刻度值Y
    for (NSInteger i = 0; i <= scaleCountY; i ++)
    {
        CGPoint scaleEndPoint = CGPointMake(originalPoint.x - scaleHeight, originalPoint.y + scaleWidthY * i);
        NSString *scaleString = [NSString stringWithFormat:@"%.1f",scaleUnit * i];
        CGRect textRect = CGRectZero;
        textRect.size = [scaleString sizeWithAttributes:textAttrs];
        textRect.size.height = MIN(textMaxHeight, textRect.size.height);
        textRect.origin.x = scaleEndPoint.x - textRect.size.width;
        textRect.origin.y = scaleEndPoint.y - textRect.size.height / 2;
        [scaleString drawInRect:textRect withAttributes:textAttrs];;
    }
}

#pragma mark - 渐变的基础配置 -
- (void)setStartPoint:(CGPoint)startPoint
{
    _startPoint = startPoint;
    
    [self refreshGradientColor];
}

- (void)setEndPoint:(CGPoint)endPoint
{
    _endPoint = endPoint;
    
    [self refreshGradientColor];
}

- (void)setColors:(NSArray *)colors
{
    _colors = colors;
    
    [self refreshGradientColor];
}

- (void)setLocations:(NSArray<NSNumber *> *)locations
{
    _locations = locations;
    
    [self refreshGradientColor];
}

- (void)setImpType:(GradientIMPType)impType
{
    if (_impType == impType)
    {
        //重复赋值
        return;
    }
    
    //清理旧数据
    [self clean];
    
    //赋值
    _impType = impType;
    
    //刷新显示
    [self refreshGradientColor];
}

- (void)setType:(GradientType)type
{
    _type = type;
    
    [self refreshGradientColor];
}

- (void)refreshGradientColor
{
    switch (self.impType)
    {
        case kGradientIMPCALayer:
        {
            [self setGradientColorWithCAGradientLayer];
            //清空drawRect之前内容
            [self setNeedsDisplay];
            break;
        }
        case kGradientIMPCGGradientRef:
        case kGradientIMPCGShadingRef:
        {
            //刷新DrawRect
            [self setNeedsDisplay];
            break;
        }
        case kGradientIMPCoreImage:
        {
            [self setNeedsDisplay];
            break;
        }
        default:
            break;
    }
}

- (void)clean
{
    switch (self.impType)
    {
        case kGradientIMPCALayer:
        {
            if (self.gradientLayer)
            {
                [self.gradientLayer removeFromSuperlayer];
                self.gradientLayer = nil;
            }
            break;
        }
        case kGradientIMPCGGradientRef:
        case kGradientIMPCGShadingRef:
        {
            break;
        }
        case kGradientIMPCoreImage:
        {
            break;
        }
        default:
            break;
    }
}

#pragma mark - 渐变实现类型 -
/**
 *  三种实现方式
 */
#pragma mark CAGradientLayer
- (void)setGradientColorWithCAGradientLayer
{
    //初始化或者刷新GradientLayer
    [self setUpGradientLayer];
    
    if ([self.gradientLayer superlayer])
    {
        //刷新,无需重新addLayer
        return;
    }
    
    //新增判断是否需要加Shape
    if (self.shapeLayer)
    {
        if ([self.shapeLayer superlayer])
        {
            [self.layer insertSublayer:self.gradientLayer below:self.shapeLayer];
        }
        else
        {
            if ([self.gradientLayer mask] == nil)
            {
                [self.gradientLayer setMask:self.shapeLayer];
            }
            [self.layer addSublayer:self.gradientLayer];
        }
    }
    else
    {
        [self.layer addSublayer:self.gradientLayer];
    }
    NSLog(@"subLayers:%ld",self.layer.sublayers.count);
}

/**
 *  GAGradientLayer Gradient['ɡreɪdiənt]梯度、渐变色
 *
 *  @return 渐变色Layer
 */
- (void)setUpGradientLayer
{
    if (self.gradientLayer == nil)
    {
        self.gradientLayer = [CAGradientLayer layer];
    }
    
    /**
     *  显示范围
     */
    self.gradientLayer.frame = self.gradientColorsFrame;
    
    /**
     *  设定渐变颜色组，
     *  CGColorRef，默认为nil，可以动画
     */
    /* The array of CGColorRef objects defining the color of each gradient
     * stop. Defaults to nil. Animatable. 
     */
    [self.gradientLayer setColors:self.colors];
    
    /**
     *  设定颜色分割点，
     *  1.分割点为空数组，显示为纯色；为nil，则为0~1的平均分割。
     *  2.分割点最好与colors个数一致，NSNumber类型，范围0~1递增。
     *  2.1位置少于颜色时，后面的多余的颜色不会显示。
     *  2.2位置多余颜色时，后面的多余的位置显示为最后一个颜色。
     *  3.分割点位置显示为对应颜色的正色，然后按照起止方向渐变。
     *  4.可以动画
     *  5.locations中的值可以为负值，负值对应的颜色不显示
     */
    /* An optional array of NSNumber objects defining the location of each
     * gradient stop as a value in the range [0,1]. The values must be
     * monotonically（[mɒnə'tɒnɪklɪ]单调的） increasing. 
     * If a nil array is given, the stops are assumed to spread
     * uniformly（['ju:nɪfɔ:mlɪ]相同的均匀的） across the [0,1] range.
     * When rendered（['rendər]渲染、表现表示）, the colors are mapped to the output
     * colorspace before being interpolated（[ɪnˈtɜrpəˌleɪt]添加插入）. 
     * Defaults to nil. Animatable.
     */
    [self.gradientLayer setLocations:self.locations];

    /**
     *  设置渐变颜色方向起始及终点位置
     *  1.颜色渐变按照colors的顺序沿着起止位置渐变
     *  2.(x,y)-->(x1,y1),变化方向为水平方向x-x1，垂直方向y-y1
     *  3.默认值[0.5,0] and [0.5,1];
     *  4.可以动画
     *
     *  (0,0)---------->(1,0)
     *    |               |
     *    |               |
     *    |               |
     *    |               |
     *  (0,1)---------->(1,1)
     *       向量坐标系统
     */
#warning Layer坐标系统
    /* The start and end points of the gradient when drawn into the layer's
     * coordinate space. The start point corresponds to the first gradient
     * stop, the end point to the last gradient stop. Both points are
     * defined in a unit coordinate space that is then mapped to the
     * layer's bounds rectangle when drawn. (I.e. [0,0] is the bottom-left
     * corner of the layer, [1,1] is the top-right corner.) The default values
     * are [.5,0] and [.5,1] respectively（[rɪ'spektɪvli]各自、依次、顺序的）. 
     * Both are animatable.
     *
     *  (0,1)---------->(1,1)
     *    |               |
     *    |               |
     *    |               |
     *    |               |
     *  (0,0)---------->(1,0)
     *       Layer坐标系统??
     */
    [self.gradientLayer setStartPoint:self.startPoint];
    [self.gradientLayer setEndPoint:self.endPoint];

    /**
     *  默认值是kCAGradientLayerAxial，表示按像素均匀变化。除了默认值也无其它选项。
     */
    /* The kind of gradient that will be drawn. Currently the only allowed
     * value is `axial' (the default value). */
    self.gradientLayer.type = kCAGradientLayerAxial;
}

#pragma mark CGGradientRef / CGShadingRef
/**
 *  QuartZ 2D实现渐变色实现的2中方式:CGShadingRef和CGGradientRef
 *  Shading(['ʃeɪdɪŋ]阴影，描影，底纹)拥有更多控制权，需要渐变过程函数。
 *  Gradient相对来说更容易使用，渐变过程由QuartZ控制。
 *  在DrawRect中调用
 *
 */
- (void)setGradientColorWithCGGradientRef
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    /**
     *  开始绘图
     */
    CGContextSaveGState(context);
    /**
     *  设置位置以及渐变范围
     */
    if (self.shapeLayer.path)
    {
        CGContextAddPath(context, self.shapeLayer.path);
    }
    else
    {
        CGContextAddRect(context, self.gradientColorsFrame);
    }
    CGContextClip(context);
    
    /**
     *  配置位置以及颜色
     */
    CGFloat locations[self.locations.count];
    for (NSInteger i = 0; i < self.locations.count; i ++)
    {
        NSNumber *location = [self.locations objectAtIndex:i];
        locations[i] = location.floatValue;
    }
    if (self.locations.count == 0)
    {
        CGFloat interval = 1.0f / (self.colors.count - 1);
        for (NSInteger i = 0; i < self.colors.count; i++)
        {
            if (i == self.colors.count)
            {
                i = 1.0;
            }
            else
            {
                locations[i] = interval * i;
            }
        }
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (CFArrayRef)self.colors,
                                                        locations);
    CGColorSpaceRelease(colorSpace);
    CGPoint cgStartPoint = CGPointZero;
    CGPoint cgEndPoint = CGPointZero;
    if (self.type == kGradientLinear)
    {
        /**
         *  线性渐变
         */
        /**
         *  比例转换为真实坐标点
         *  start(x,y)--->start(x*rect.width,y*rect.height)
         */
        cgStartPoint.x = self.gradientColorsFrame.origin.x + self.startPoint.x * self.gradientColorsFrame.size.width;
        cgStartPoint.y = self.gradientColorsFrame.origin.y + self.startPoint.y * self.gradientColorsFrame.size.height;
        cgEndPoint.x = self.gradientColorsFrame.origin.x + self.endPoint.x * self.gradientColorsFrame.size.width;
        cgEndPoint.y = self.gradientColorsFrame.origin.y + self.endPoint.y * self.gradientColorsFrame.size.height;
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    cgStartPoint,
                                    cgEndPoint,
                                    0);
    }
    else if (self.type == kGradientRadial)
    {
        /**
         *  辐射渐变
         */
        CGFloat startRadius = 0;  //必须为0
        CGFloat endRadius = MIN(self.gradientColorsFrame.size.width, self.gradientColorsFrame.size.height) / 2;
        cgEndPoint.x = CGRectGetMidX(self.gradientColorsFrame);
        cgEndPoint.y = CGRectGetMidY(self.gradientColorsFrame);
        cgStartPoint.x = cgEndPoint.x - endRadius * self.startPoint.x;
        cgStartPoint.y = cgEndPoint.y - endRadius * self.startPoint.y;
        CGContextDrawRadialGradient(context,
                                    gradient,
                                    cgStartPoint,
                                    startRadius,
                                    cgEndPoint,
                                    endRadius,
                                    0);
    }
    else if (self.type == kGradientAxial)
    {
        /**
         *  径向渐变
         */
        CGFloat startRadius = 10;
        CGFloat endRadius = 70;
        CGRect startPointRect = CGRectInset(self.gradientColorsFrame, startRadius, startRadius);
        cgStartPoint.x = startPointRect.origin.x + startPointRect.size.width * self.startPoint.x;
        cgStartPoint.y = startPointRect.origin.y + startPointRect.size.height * self.startPoint.y;
        CGRect endPointRect = CGRectInset(self.gradientColorsFrame, endRadius, endRadius);
        cgEndPoint.x = endPointRect.origin.x + endPointRect.size.width * self.endPoint.x;
        cgEndPoint.y = endPointRect.origin.y + endPointRect.size.height * self.endPoint.y;
        CGContextDrawRadialGradient(context,
                                    gradient,
                                    cgStartPoint,
                                    startRadius,
                                    cgEndPoint,
                                    endRadius,
                                    0);
    }
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
}

#warning Shading无效
- (void)setGradientColorWithCGShadingRef
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    if (self.shapeLayer.path)
    {
        CGContextAddPath(context, self.shapeLayer.path);
    }
    else
    {
        CGContextAddRect(context, self.gradientColorsFrame);
    }
    CGContextClip(context);

    CGFloat locations[self.locations.count];
    for (NSInteger i = 0; i < self.locations.count; i ++)
    {
        NSNumber *location = [self.locations objectAtIndex:i];
        locations[i] = location.floatValue;
    }
    if (self.locations.count == 0)
    {
        CGFloat interval = 1.0f / (self.colors.count - 1);
        for (NSInteger i = 0; i < self.colors.count; i++)
        {
            if (i == self.colors.count)
            {
                i = 1.0;
            }
            else
            {
                locations[i] = interval * i;
            }
        }
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGPoint cgStartPoint = CGPointZero;
    CGPoint cgEndPoint = CGPointZero;
    if (self.type == kGradientLinear)
    {
        /**
         *  线性渐变
         */
//        cgStartPoint = self.startPoint;
//        cgEndPoint = self.endPoint;
        cgStartPoint = CGPointMake(0,0.5);
        cgEndPoint = CGPointMake(1,0.5);
        bool extendStart = false;
        bool extendEnd = false;
        CGFunctionRef shadingFunc = shadingColorFunction(colorSpace);
        CGShadingRef shading = CGShadingCreateAxial(colorSpace,
                                                    cgStartPoint,
                                                    cgEndPoint,
                                                    shadingFunc,
                                                    extendStart,
                                                    extendEnd);
        CGContextDrawShading(context, shading);
        CGShadingRelease(shading);
        CGColorSpaceRelease(colorSpace);
        CGFunctionRelease(shadingFunc);
    }
    else if (self.type == kGradientRadial)
    {
        /**
         *  辐射渐变
         */
//        cgStartPoint = self.startPoint;
//        cgEndPoint = self.endPoint;
        CGFloat startRadius = 0.0f;  //必须为0
        CGFloat endRadius = 1.0;
        cgStartPoint = CGPointMake(0.25,0.3);
        cgEndPoint = CGPointMake(.7,0.7);
        bool extendStart = false;
        bool extendEnd = false;
        CGFunctionRef shadingFunc = shadingColorFunction(colorSpace);
        CGShadingRef shading = CGShadingCreateRadial(colorSpace,
                                                     cgStartPoint,
                                                     startRadius,
                                                     cgEndPoint,
                                                     endRadius,
                                                     shadingFunc,
                                                     extendStart,
                                                     extendEnd);
        CGContextDrawShading(context, shading);
        CGShadingRelease(shading);
        CGColorSpaceRelease(colorSpace);
        CGFunctionRelease(shadingFunc);
    }
    else if (self.type == kGradientAxial)
    {
        /**
         *  径向渐变
         */
//        cgStartPoint = self.startPoint;
//        cgEndPoint = self.endPoint;
        CGFloat startRadius = .1;
        CGFloat endRadius = .25;
        cgStartPoint = CGPointMake(0.25,0.3);
        cgEndPoint = CGPointMake(.7,0.7);
        bool extendStart = false;
        bool extendEnd = false;
        CGFunctionRef shadingFunc = shadingColorFunctionSin(colorSpace);
        CGShadingRef shading = CGShadingCreateRadial(colorSpace,
                                                     cgStartPoint,
                                                     startRadius,
                                                     cgEndPoint,
                                                     endRadius,
                                                     shadingFunc,
                                                     extendStart,
                                                     extendEnd);
        CGContextDrawShading(context, shading);
        CGShadingRelease(shading);
        CGColorSpaceRelease(colorSpace);
        CGFunctionRelease(shadingFunc);
    }
    
    CGContextRestoreGState(context);
}

/**
 *  CGFunction回调 将一个常数数组中的值乘以输入值来计算颜色组件值
 *
 *
 *  @param info   这个值可以为NULL或者是一个指向传递给CGShading创建函数的数据
 *  @param inPut  Quartz传递in数组给回调。数组中的值必须在为CGFunction对象定义的输入值范围内。例如，输入范围是0到1；
 *  @param outPut 我们的回调函数传递out数组给Quartz。它包含用于颜色空间中每个颜色组件的元素及一个alpha值。输出值应该在CGFunction对象中定义的输出值的范围内，例如，输出范围是0到1；
 *
 *  @return
 */
static void calculateShadingValues(void *info,
                                   const CGFloat *inPut,
                                   CGFloat *outPut)
{
    CGFloat v;
    size_t i, components;
    static const CGFloat c[] = {1,0,.5,0};
    
    components = (size_t)info;
    
    v = *inPut;
    for (i = 0; i < components - 1; i++){
        *outPut++ = c[i] * v;
    }
    *outPut++ = 1; //alpha
}

/**
 *  函数打包成CGFunctionRef
 */
static CGFunctionRef shadingColorFunction(CGColorSpaceRef colorSpace)
{
    size_t components;
    static const CGFloat inputValueRange[2] = {0,1};
    static const CGFloat outPutvalueRage[8] = {0,1,0,1,
                                               0,1,0,1};
    static const CGFunctionCallbacks callBacks = {0,
        &calculateShadingValues,
        NULL};
    
    components = 1 + CGColorSpaceGetNumberOfComponents(colorSpace);
    return CGFunctionCreate((void *)components,
                            1,
                            inputValueRange,
                            components,
                            outPutvalueRage,
                            &callBacks);
}

/**
 *  获取一个输入值并计算N个值，即颜色空间的每个颜色组件加一个alpha值
 *
 *  @return
 */
static void calculateShadingValuesSinFunc(void *info,
                                          const CGFloat *inPut,
                                          CGFloat *outPut)
{
    size_t i, components;
    double frequency[4] = {55, 220, 110, 0};
    
    components = (size_t)info;
    
    for (i = 0; i < components - 1; i++){
        *outPut++ = (1 + sin(*inPut * frequency[i])) / 2;
    }
    *outPut++ = 1; //alpha
}

static CGFunctionRef shadingColorFunctionSin(CGColorSpaceRef colorSpace)
{
    size_t components;
    static const CGFloat inputValueRange[2] = {0,1};
    static const CGFloat outPutvalueRage[8] = {0,1,0,1,
        0,1,0,1};
    static const CGFunctionCallbacks callBacks = {0,
        &calculateShadingValuesSinFunc,
        NULL};
    
    components = 1 + CGColorSpaceGetNumberOfComponents(colorSpace);
    return CGFunctionCreate((void *)components,
                            1,
                            inputValueRange,
                            components,
                            outPutvalueRage,
                            &callBacks);
}

#pragma mark Core Image
/**
 *  在DrawRect中调用
 *  Apple’s Core Image Filter Reference
 */
- (void)setGradientColorWithCoreImage
{
    UIImage *gradientImage = [self gradientImageWithCoreImage];
    
    /**
     *  以图片的左上角为起点，开始画
     */
//    [gradientImage drawAtPoint:CGPointZero];
    
    /**
     *  将图片画到Rect中，Image会被缩放
     */
    [gradientImage drawInRect:self.gradientColorsFrame];
}

/**
 *  利用CoreImage生成Image
 *
 *  @return
 */
- (UIImage *)gradientImageWithCoreImage
{
    
    /**
     *  比例转换为真实坐标点
     *  start(x,y)--->start(x*)
     */
#warning CIImage Coordinate
//    self.startPoint = CGPointZero;
//    self.endPoint = CGPointMake(0, 1);
    CGPoint ciStartPoint = CGPointMake(self.startPoint.x * self.gradientColorsFrame.size.width, (self.startPoint.y) * self.gradientColorsFrame.size.height);
    CGPoint ciEndPoint = CGPointMake(self.endPoint.x * self.gradientColorsFrame.size.width, (self.endPoint.y) * self.gradientColorsFrame.size.height);
    
    CIFilter *filter = [CIFilter filterWithName:@"CILinearGradient"];
    CIVector *vector0 = [CIVector vectorWithX:ciStartPoint.x
                                            Y:ciStartPoint.y];
    CIVector *vector1 = [CIVector vectorWithX:ciEndPoint.x
                                            Y:ciEndPoint.y];
    [filter setValue:vector0 forKey:@"inputPoint0"];
    [filter setValue:vector1 forKey:@"inputPoint1"];
    [filter setValue:[CIColor colorWithCGColor:(CGColorRef)[self.colors objectAtIndex:0]] forKey:@"inputColor0"];
    [filter setValue:[CIColor colorWithCGColor:(CGColorRef)[self.colors objectAtIndex:1]] forKey:@"inputColor1"];
    
    CIImage *ciImage = filter.outputImage;
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [ciContext createCGImage:ciImage
                                         fromRect:self.gradientColorsFrame];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    UIImage *myimage = [UIImage imageNamed:@"tree.jpg"];
//    CIImage *cimage = [[CIImage alloc] initWithImage:myimage];
//    
//    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone"];
//    [sepiaFilter setDefaults];
//    [sepiaFilter setValue:cimage forKey:@"inputImage"];
//    [sepiaFilter setValue:[NSNumber numberWithFloat:0.8f]
//                   forKey:@"inputIntensity"];
//    
//    CIImage *image = [sepiaFilter outputImage];
//    CIContext *context = [CIContext contextWithOptions: nil];
//    CGImageRef cgImage = [context createCGImage:
//                          image fromRect: image.extent];
//    UIImage *resultUIImage = [UIImage imageWithCGImage: cgImage];
//    
//    CGRect imageRect =[[UIScreen mainScreen] bounds];
//    [resultUIImage drawInRect:imageRect];
//}

#pragma mark - 渐变显示范围控制 -
- (void)gradientRange:(NSInteger)rangeType
{
    if (rangeType == 0)
    {
        //正方形渐变
        if (self.impType == kGradientIMPCALayer)
        {
            if ([self.shapeLayer superlayer])
            {
                [self.shapeLayer removeFromSuperlayer];
            }
            
            if (self.gradientLayer.mask != nil)
            {
                [self.gradientLayer setMask:nil];
            }
        }
        else
        {
            self.shapeLayer = nil;
            [self setNeedsDisplay];
        }
    }
    else if (rangeType == 1)
    {
        //显示多边形路径
        if (self.impType == kGradientIMPCALayer)
        {
            [self showRangePath];
        }
        else
        {
            [self getMaskLayer];
            [self setNeedsDisplay];
        }
    }
    else if (rangeType == 2)
    {
        //修改渐变结果
        if (self.impType == kGradientIMPCALayer)
        {
            [self maskPath];
        }
        else
        {
            [self getMaskLayer];
            [self setNeedsDisplay];
        }
    }
}

- (void)showRangePath
{
    //清空Mask效果
    if (self.gradientLayer && self.gradientLayer.mask != nil)
    {
        [self.gradientLayer setMask:nil];
    }

    if ([self.shapeLayer superlayer])
    {
        //已经添加过了，直接return
        return;
    }
    
    //是否需要初始化
    if (self.shapeLayer == nil)
    {
        [self getMaskLayer];
    }
    
    //添加Layer
    if ([self.gradientLayer superlayer])
    {
        [self.layer insertSublayer:self.shapeLayer above:self.gradientLayer];
    }
    else
    {
        [self.layer addSublayer:self.shapeLayer];
    }
}

- (void)maskPath
{
    //是否需要初始化
    if (self.shapeLayer == nil)
    {
        [self getMaskLayer];
    }
    else
    {
        //是否需要移除
        if ([self.shapeLayer superlayer])
        {
            [self.shapeLayer removeFromSuperlayer];
        }
    }
    
    //mask效果
    if (self.gradientLayer && self.gradientLayer.mask == nil)
    {
        [self.gradientLayer setMask:self.shapeLayer];
    }
}

- (void)getMaskLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(COMMON_VI_10 * 4, COMMON_VI_10 * 4)];
    [path addLineToPoint:CGPointMake(self.gradientColorsFrame.size.width - COMMON_VI_10 * 4, COMMON_VI_10 * 4)];
    [path addLineToPoint:CGPointMake(self.gradientColorsFrame.size.width - COMMON_VI_10 * 4, self.gradientColorsFrame.size.height / 2)];
    [path addLineToPoint:CGPointMake(self.gradientColorsFrame.size.width/2 - COMMON_VI_10 * 2, self.gradientColorsFrame.size.height - COMMON_VI_10 * 4)];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.frame = self.bounds;
    shapLayer.lineWidth = 2.0;
    shapLayer.strokeColor = [UIColor greenColor].CGColor;
    shapLayer.fillColor = [UIColor whiteColor].CGColor;
    shapLayer.path = path.CGPath;
    self.shapeLayer = shapLayer;
}

#pragma mark - 渐变色的动画效果 -
- (void)showAnimation
{
    /**
     *  Layer的动画是否添加
     */
#warning Animation 无效
    if (![self.gradientLayer animationForKey:@"locationsAnimation"])
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
        animation.fromValue = @[@(0),@(0)];
        animation.toValue = self.locations;
        animation.duration = 1.5f;
        animation.repeatCount = INT64_MAX;
        [self.gradientLayer addAnimation:animation forKey:@"locationsAnimation"];
    }
    else
    {
        [self.gradientLayer removeAnimationForKey:@"locationsAnimation"];
    }
}

@end
