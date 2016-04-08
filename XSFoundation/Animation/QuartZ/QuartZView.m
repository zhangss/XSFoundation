//
//  QuartZView.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "QuartZView.h"

/**
 *  QuartZ 2D注意事项
 *  1.使用包含Create和Copy词缀的API时，创建出来的对象需要释放，否则内存泄露
 *  2.被Retain的对象需要在不使用时Release它
 *  3.UIKit中原点在左上角，Y轴正方向向下。
 *    QuartZ中原点在左下角，Y周正方向向上。
 */

@implementation QuartZView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //获取图形的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] setFill];
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
//    [[UIColor redColor] setStroke];
    
    //绘制贝兹曲线
    //贝兹曲线是通过移动一个起始点，然后通过两个控制点,还有一个中止点，调用CGContextAddCurveToPoint() 函数绘制
//    CGContextMoveToPoint(context, 10, 10);
//    CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400);
//    CGContextStrokePath(context);
    
    //绘制二次贝兹曲线
//    CGContextMoveToPoint(context, 10, 200);
//    CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200);
//    CGContextStrokePath(context);
    
    CGFloat x = 10.f;
    CGFloat y = rect.size.height / 2;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x, y);
    CGContextAddLineToPoint(context, rect.size.width - 20, y);
    //为闭合路径描边
    CGContextStrokePath(context);
    //关闭路径
    CGContextClosePath(context);
    
    y = 10.f;
    x = rect.size.width / 2;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x, y);
    CGContextAddLineToPoint(context, x, rect.size.height - 20);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}
#pragma mark - Quarz 2D Base -
- (void)setBgColors
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    CGContextFillRect(context, CGRectMake(COMMON_VI_10, COMMON_VI_10, COMMON_VI_10, COMMON_VI_10));
    
    /**
     *  Antialiasing(['ænti:eɪlɪəsɪŋ]反锯齿、抗混淆)
     *  反锯齿效果 人为的较正在位图中绘制文本或形状时产生的锯齿边缘
     *  当位图的分辩率明显低于人眼的分辩率时就会产生锯齿。为了使位图中的对象显得平滑，Quartz使用不同的颜色来填充形状周边的像素。通过这种方式来混合颜色，使形状看起来更平滑。
     *  两个同时设置为YES时才生效该效果。默认开启
     */
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES);
}

#pragma mark - Path
- (void)setShapePath
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, COMMON_VI_10, COMMON_VI_10);
    
    CGContextAddPath(context, nil);
    
    CGContextClosePath(context);
    
    CGContextSetLineWidth(context, 1.0f);
    /**
     *  线之间的连接点的样式，默认Miter
     *  kCGLineJoinMiter,
     *  kCGLineJoinRound,
     *  kCGLineJoinBevel
     */
    CGContextSetLineJoin(context, self.lineJone);
    /**
     *  线的端点样式，默认Butt
     *  kCGLineCapButt,
     *  kCGLineCapRound,
     *  kCGLineCapSquare
     */
    CGContextSetLineCap(context, self.lineCap);
    /**
     *  LienDash pattern虚线模式
     *  CGFloat phase 虚线模式的起始点
     *  const CGFloat * _Nullable lengths 虚线段的长度
     */
//    CGContextSetLineDash(context, <#CGFloat phase#>, <#const CGFloat * _Nullable lengths#>, <#size_t count#>);
    
    /**
     *  填充色
     */
//        CGContextSetFillColorSpace(context, <#CGColorSpaceRef  _Nullable space#>)
//        CGContextSetFillColor(context, <#const CGFloat * _Nullable components#>)
//        CGContextSetFillColorWithColor(context, <#CGColorRef  _Nullable color#>)
    
    /**
     *  线框色
     */
//        CGContextSetStrokeColorSpace(context, <#CGColorSpaceRef  _Nullable space#>)
//        CGContextSetStrokeColor(context, <#const CGFloat * _Nullable components#>)
//        CGContextSetStrokeColorWithColor(context, <#CGColorRef  _Nullable color#>)

    CGContextStrokePath(context);
}

//- (void)pathWithMutablePath
//{
//    //    CGPathRef path = nil;
//    
//    CGAffineTransform transForm = NULL;
//    //CGContextBeginPath
//    CGMutablePathRef mutablePath = CGPathCreateMutable();
//    //CGContextMoveToPoint
//    CGPathMoveToPoint(mutablePath, transForm, COMMON_VI_10, COMMON_VI_10);
//    //CGContexAddLineToPoint
//    CGPathAddLineToPoint(mutablePath, transForm,self.bounds.size.width - COMMON_VI_10, COMMON_VI_10);
//    
//    //
//    CGPathAddArc(mutablePath,
//                 transForm,
//                 COMMON_VI_10,
//                 COMMON_VI_10,
//                 self.bounds.size.width / 2,
//                 0.0f,
//                 M_2_PI,
//                 YES);
//    
//    //CGContextAddPath
//    CGPathAddPath(mutablePath, transForm, mutablePath);
//    //CGContexClosePath
//    CGPathCloseSubpath(mutablePath);
//    
//    CGPathRelease(mutablePath);
//}

#pragma mark - Color And ColorSpace
/**
 *  颜色
 *  Color Management Overview
 *
 */
/**
 *  颜色空间
 */
- (void)quartZColorSpace
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 1.0f);
    
    /**
     *  清除alpha值
     */
    CGContextClearRect(context, self.bounds);
    
    /**
     *  IOS不支持设备依赖颜色空间或通用颜色空间。IOS应用程序必须使用设备颜色空间(device color space)
     *  为了创建设备依赖颜色空间，我们需要给Quartz提供白色参考点，黑色参考点及特殊设备的gamma值。Quartz使用这些信息将源颜色空间的颜色值转化为输出设备颜色空间的颜色值。
     */
    /**
     *  L*a*b是非线性转换，它属于Munsell颜色符号系统(该系统使用色度、值、饱和度来指定颜色)。 L组件表示亮度值，a组件表示绿色与红色之间的值，b组件表示蓝色与黄色之间的值。该颜色空间设计用于模拟人脑解码颜色
     *
     *  @param whitePoint#> <#whitePoint#> description#>
     *  @param blackPoint#> <#blackPoint#> description#>
     *  @param range#>      <#range#> description#>
     *
     *  @return <#return value description#>
     */
//    CGColorSpaceCreateLab(<#const CGFloat *whitePoint#>, <#const CGFloat *blackPoint#>, <#const CGFloat *range#>)
    
    /**
     *  ICC颜色空间是由ICC(由国际色彩聪明，International Color Consortium)颜色配置而来的。ICC颜色配置了设备支持的颜色域，该颜色域与其它设备属性相符，所以该信息可被用于将一个设备的颜色空间精确地转换为另一个设备的颜色空间。大多数设备制造商都支持ICC配置。一些彩色显示器和打印机都内嵌了ICC信息，用于处理诸如TIFF的位图格式。
     *
     *  @param nComponents#> <#nComponents#> description#>
     *  @param range#>       <#range#> description#>
     *  @param profile#>     <#profile#> description#>
     *  @param alternate#>   <#alternate#> description#>
     *
     *  @return <#return value description#>
     */
//    CGColorSpaceCreateICCBased(<#size_t nComponents#>, <#const CGFloat * _Nullable range#>, <#CGDataProviderRef  _Nullable profile#>, <#CGColorSpaceRef  _Nullable alternate#>)
    
    /**
     *  标准化RGB是设备依赖的RGB颜色空间，它表示相对于白色参考点(设备可生成的最白的颜色)的颜色。
     *
     *  @param whitePoint#> <#whitePoint#> description#>
     *  @param blackPoint#> <#blackPoint#> description#>
     *  @param gamma#>      <#gamma#> description#>
     *  @param matrix#>     <#matrix#> description#>
     *
     *  @return <#return value description#>
     */
//    CGColorSpaceCreateCalibratedRGB(<#const CGFloat *whitePoint#>, <#const CGFloat *blackPoint#>, <#const CGFloat *gamma#>, <#const CGFloat *matrix#>)
    
    /**
     *  标准化灰度是设备依赖的灰度颜色空间，它表示相对于白色参考点(设备可生成的最白的颜色)的颜色。
     *
     *  @param whitePoint#> <#whitePoint#> description#>
     *  @param blackPoint#> <#blackPoint#> description#>
     *  @param gamma#>      <#gamma#> description#>
     *
     *  @return <#return value description#>
     */
//    CGColorSpaceCreateCalibratedGray(<#const CGFloat *whitePoint#>, <#const CGFloat *blackPoint#>, <#CGFloat gamma#>)
    
    /**
     *  通用颜色空间的颜色与系统匹配。大部分情况下，结果是可接受的。就像名字所暗示的那样，每个“通用”颜色空间(generic gray, generic RGB, generic CMYK)都是一个指定的设备依赖颜色空间。
     *  通过颜色空间非常容易使用；我们不需要提供任何参考点信息。
     *
     *  kCGColorSpaceGenericGray:指定通用灰度颜色空间，该颜色空间是单色的，可以指定从0.0(纯黑)到1.0(纯白)范围内的颜色值。
     *  kCGColorSpaceGenericRGB：指定通用RGB颜色空间，该颜色空间中的颜色值由三个组件(red, green, blue)组成，主要用于彩色显示器上的像素。RGB颜色空间中的每个组件的值范围是[0.0, 1.0]。
     *  kCGColorSpaceGenericCMYK：指定通用CMYK颜色空间，该颜色空间的颜色值由四个组件(cyan, magenta, yellow, black)，主要用于打印机。CMYK颜色空间的每个组件的值范围是[0.0, 1.0]。
     */
//    CGColorSpaceCreateWithName(<#CFStringRef  _Nullable name#>);
    
    /**
     *  设备颜色空间主要用于IOS应用程序，因为其它颜色空间无法在IOS上使用。大多数情况下，Mac OS X应用程序应使用通用颜色空间，而不使用设备颜色空间。但是有些Quartz程序希望图像使用设备颜色空间。例如，如果调用CGImageCreateWithMask函数来指定一个图像作为遮罩，图像必须在设备的灰度颜色空间(device gray color space)中定义。
     */
//    CGColorSpaceCreateDeviceGray(); //创建设备依赖灰度颜色空间
//    CGColorSpaceCreateDeviceRGB();  //创建设备依赖RGB颜色空间
//    CGColorSpaceCreateDeviceCMYK(); //创建设备依赖CMYK颜色空间

    /**
     *  索引颜色空间包含一个有256个词目的颜色表，和词目映射到基础颜色空间。颜色表中每个词目指定一个基础颜色空间中的颜色值。使用CGColorSpaceCreateIndexed函数来创建。
     *
     *  @param baseSpace#>  <#baseSpace#> description#>
     *  @param lastIndex#>  <#lastIndex#> description#>
     *  @param colorTable#> <#colorTable#> description#>
     *
     *  @return <#return value description#>
     */
//    CGColorSpaceCreateIndexed(<#CGColorSpaceRef  _Nullable baseSpace#>, <#size_t lastIndex#>, <#const unsigned char * _Nullable colorTable#>)
    
}

/**
 *  颜色
 *  Quartz提供了一套函数用于设置填充颜色、线框颜色、颜色空间和alpha值。
 *  每个颜色参数都是图形状态参数，这就意味着一旦设置了，设置将被保存并影响后续操作，直到被修改为止。
 *  一个颜色必须有相关联的颜色空间。否则，Quartz不知道如何解析颜色值。进一步说，说是我们必须为绘制目标提供一个合适的颜色空间。如图4-4所示，左边是CMYK颜色空间中的蓝色填充色，右边是RGB颜色空间中的蓝色填充色。这两个颜色值在理论上是一样的，但只有在相同颜色空间下的相同颜色值显示出来才是一样的。
 */
- (void)quartZColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colorComponents[] = {1,0,0,1};
    CGColorRef color = CGColorCreate(colorSpace, colorComponents);
    
    CGColorRelease(color);
    CGColorSpaceRelease(colorSpace);

    /**
     *  “再现意图”用于指定如何将源颜色空间的颜色映射到图形上下文的目标颜色空间的颜色范围内。如果不显示指定再现意图，Quartz使用相对色度再现意图(relative colorimetric rendering intent)应用于所有绘制(不包含位图图像)。对于位图图像，Quartz默认使用感知(perceptual)再现意图。
     
     我们可以调用CGContextSetRenderingIntent函数来设置再现意图，并传递图形上下文(graphics context)及下例常量作为参数：
     
     kCGRenderingIntentDefault：使用默认的渲染意图。
     kCGRenderingIntentAbsoluteColorimetric：绝对色度渲染意图。将输出设备颜色域外的颜色映射为输出设备域内与之最接近的颜色。这可以产生一个裁减效果，因为色域外的两个不同的颜色值可能被映射为色域内的同一个颜色值。当图形使用的颜色值同时包含在源色域及目标色域内时，这种方法是最好的。常用于logo或者使用专色(spot color)时。
     kCGRenderingIntentRelativeColorimetric：相对色度渲染意图。转换所有的颜色(包括色域内的)，以补偿图形上下文的白点与输出设备白点之间的色差。kCGRenderingIntentPerceptual：感知渲染意图。通过压缩图形上下文的色域来适应输出设备的色域，并保持源颜色空间的颜色之间的相对性。感知渲染意图适用于相片及其它复杂的高细度图片。
     kCGRenderingIntentSaturation：饱和度渲染意图。把颜色转换到输出设备色域内时，保持颜色的相对饱和度。结果是包含亮度、饱和度颜色的图片。饱和度意图适用于生成低细度的图片，如描述性图表。
     *
     *  @param context  <#context description#>
     *  @param intent#> <#intent#> description#>
     *
     *  @return <#return value description#>
     */
//    CGContextSetRenderingIntent(context, kCGRenderingIntentDefault);
}

#pragma mark - Mask
/**
 *  裁剪路径
 *  当前裁剪区域是从路径中创建，作为一个遮罩，从而允许遮住我们不想绘制的部分。
 *  当我们绘制的时候，Quartz只渲染裁剪区域里面的东西。裁剪区域内的闭合路径是可见的；而在区域外的部分是不可见的。
 *  当图形上下文初始创建时，裁减区域包含上下文所有的可绘制区域。我们可以通过设置当前路径来改变裁剪区域，然后使用裁减函数来取代绘制函数。裁剪函数与当前已有的裁剪区域求交集以获得路径的填充区域。因此，我们可以求交取得裁减区域，缩小图片的可视区域，但是不能扩展裁减区域。
 *  裁减区域是图形状态的一部分。为了恢复先前的裁减区域，我们可以在裁减前保存图形状态，并在裁减绘制后恢复图形状态。
 */
- (void)quartZClipAndMask
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(COMMON_VI_10, COMMON_VI_10, COMMON_VI_10 * 4, COMMON_VI_10 * 4));
    CGContextClosePath(context);
    CGContextClip(context);
}

#pragma mark - CTM
/**
 *  CTM(current transformation matrix)在创建图形上下文后，CTM是单位矩阵，我们可以使用 Quartz的变换函数来修改CTM，从而修改用户空间中的绘制操作。
 *  Quartz 2D 绘制模型定义了两种独立的坐标空间：用户空间(用于表现文档页)和设备空间(用于表现设备的本地分辨率)。用户坐标空间用浮点数表示坐标，与设备空间的像素分辨率没有关系。当我们需要一个点或者显示文档时， Quartz会将用户空间坐标系统映射到设备空间坐标系统。因此，我们不需要重写应用程序或添加额外的代码来调整应用程序的输出以适应不同的设备。
 *  我们可能使用Quartz内置的变换函数方便的平移、旋转和缩放我们的绘图。CTM总是用于表示用户空间和设备空间的当前映射关系。这种映射确保了应用程序的输出在任何显示器或打印机上看上去都很棒。
 *  变换CTM之前，我们需要保存图形状态，以便绘制后能恢复。
 *  与CTM函数相关的四种操作—平移、旋转、缩放和联结。效果可以叠加。
 */
- (void)quartZCTM
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /**
     *  平移变换根据我们指定的x, y轴的值移动坐标系统的原点。我们通过调用CGContextTranslateCTM函数来修改每个点的x, y坐标值。如图5-3显示了一幅图片沿x轴移动了100个单位，沿y轴移动了50个单位。具体代码如下：
     *
     *  @param context <#context description#>
     *  @param tx#>    <#tx#> description#>
     *  @param ty#>    <#ty#> description#>
     *
     *  @return <#return value description#>
     */
    CGContextTranslateCTM(context, 100, 50);
    
    /**
     *  旋转变换根据指定的角度来移动坐标空间。我们调用CGContextRotateCTM函数来指定旋转角度(以弧度为单位)。图5-4显示了图片以原点(左下角)为中心旋转45度，代码所下所示：

     *  @param CGFloat angle
     *
     *  @return <#return value description#>
     */
    CGContextRotateCTM(context, radians(-45.f));
    
    /**
     *  缩放操作根据指定的x, y因子来改变坐标空间的大小，从而放大或缩小图像。x, y因子的大小决定了新的坐标空间是否比原始坐标空间大或者小。另外，通过指定x因子为负数，可以倒转x轴，同样可以指定y因子为负数来倒转y轴。通过调用CGContextScaleCTM函数来指定x, y缩放因子。图5-5显示了指定x因子为0.5，y因子为0.75后的缩放效果。
     *
     *  @param context <#context description#>
     *  @param sx#>    <#sx#> description#>
     *  @param sy#>    <#sy#> description#>
     *
     *  @return <#return value description#>
     */
    CGContextScaleCTM(context, 0.5, 0.75);
    
    /**
     *  <#Description#>
     *
     *  @param void <#void description#>
     *
     *  @return <#return value description#>
     */
}

#pragma mark - Shadow
/**
 *  阴影是绘制在一个图形对象下的且有一定偏移的图片，它用于模拟光源照射到图形对象上所形成的阴影效果，文本也可以有阴影。阴影可以让一幅图像看上去是立体的或者是浮动的。
 *  阴影有三个属性：
 x偏移值，用于指定阴影相对于图片在水平方向上的偏移值。
 y偏移值，用于指定阴影相对于图片在竖直方向上的偏移值。
 模糊(blur)值，用于指定图像是有一个硬边(hard edge)，还是一个漫射边(diffuse edge)
 *  阴影被设置后，任何绘制的对象都有一个阴影，且该阴影默认在设备RGB颜色空间中呈现出黑色的且alpha值为1/3。换句话说，阴影默认是用RGBA值{0, 0, 0, 1.0/3.0}设置的。
 *  Quartz中的阴影是图形状态的一部分
 *
 */
- (void)quartZShadow
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    /**
     *
     *  一个正值的x偏移量指定阴影位于图形对象的右侧。
     *  在Mac OS X中，正值的y指定阴影位于图形对象的上边，这与Quartz 2D默认的坐标值匹配。
     *  在iOS中，如果我们用Quartz 2D API来创建PDF或者位图图形上下文，则正值的y指定阴影位于图形对象的上边。
     *  在iOS中，如果图形上下文是由UIKit创建的，则正值的y指定阴影位于图形对象的下边。这与UIKit坐标系统相匹配。
     *  阴影绘制惯例不受CTM影响.
     *
     *  @param offset#> offset description#>
     *  @param blur#>   <#blur#> description#>
     *  @param color#>  <#color#> description#>
     *
     *  @return <#return value description#>
     */
    CGContextSetShadow(context, self.shadowOffSet, self.blur);
    CGContextSetShadowWithColor(context, self.shadowOffSet, self.blur, self.shadowColor.CGColor);
    
    CGContextRestoreGState(context);
}

#pragma mark - TransparencyLayers透明层
/**
 *  透明层(TransparencyLayers)通过组合两个或多个对象来生成一个组合图形。组合图形被看成是单一对象。当需要在一组对象上使用特效时，透明层非常有用
 *  Quartz的透明层类似于许多流行的图形应用中的层。层是独立的实体。Quartz维护为每个上下文维护一个透明层栈，并且透明层是可以嵌套的。但由于层通常是栈的一部分，所以我们不能单独操作它们。
 *
 */
- (void)quartZTransparency
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGSize myShadowOffset = CGSizeMake (10, -20);
    CGContextSetShadow (context, myShadowOffset, 10);
    
    /**
     *  开始透明层绘画
     *  在开始透明层操作后，我们可以绘制任何想显示在层上的对象。指定上下文中的绘制操作将被当成一个组合对象绘制到一个透明背景上。这个背景被当作一个独立于图形上下文的目标缓存。
     *
     *  @param context         <#context description#>
     *  @param auxiliaryInfo#> <#auxiliaryInfo#> description#> Quartz 2D API中没有使用字典,
     *
     *  @return <#return value description#>
     */
    CGContextBeginTransparencyLayer(context, NULL);
    
    // Your drawing code here
    // 绘制三个层叠带阴影的矩形
    CGFloat wd,ht;
    wd = 100;
    ht = 100;
    CGContextSetRGBFillColor (context, 0, 1, 0, 1);
    CGContextFillRect (context, CGRectMake (wd/3+ 50,ht/2 ,wd/4,ht/4));
    CGContextSetRGBFillColor (context, 0, 0, 1, 1);
    CGContextFillRect (context, CGRectMake (wd/3-50,ht/2-100,wd/4,ht/4));
    CGContextSetRGBFillColor (context, 1, 0, 0, 1);
    CGContextFillRect (context, CGRectMake (wd/3,ht/2-50,wd/4,ht/4));

    /**
     *  透明层设置完毕
     *  当绘制完成后，Quartz将结合对象放入上下文，并使用上下文的全局alpha值、阴影状态及裁减区域作用于组合对象。
     */
    CGContextEndTransparencyLayer(context);
}

#pragma mark - Patrern

#pragma mark - Bitmap Image 位图
/**
 *  一个位图是一个像素数组。每一个像素表示图像中的一个点。JPEG, TIFF和PNG图像文件都是位图。应用程序的icon也是位图。位图被限定在一个矩形内。但是通过使用alpha分量，它们可以呈现不同的形式，也可以旋转或被裁剪。ColorSync提供了位图支持的颜色空间
 *
 */
- (void)quartZBitmapImage
{

}

#pragma mark - CGLayerRef

#pragma mark - Gradient(详见GradientView)

#pragma mark - QuartZ Blend Mode
- (void)quartZBlendMode
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    /**
     *  混合模式指定了Quartz如何将绘图绘制到背景上
     *  默认值,kCGBlendModeNormal:普通混合模式，该模式使用如下公式来计算前景绘图与背景绘图如何混合result = (alpha * foreground) + (1 - alpha) *background。结果为所有绘制于背景之上的绘图都会遮掩住背景。
     *  kCGBlendModeMultiply:正片叠底混合模式指定将前景的图片采样与背景图片采样相乘。结果颜色至少与两个采样颜色之一一样暗。
     *  kCGBlendModeScreen:屏幕混合模式指定将前景图片采样的反转色与背景图片的反转色相乘。结果颜色至少与两种采样颜色之一一样亮。
     *  kCGBlendModeOverlay:叠加混合模式是将前景图片与背景图片或者正片叠底，或者屏幕化，这取决于背景颜色。背景颜色值与前景颜色值以反映出背景颜色的亮度与暗度。
     *  kCGBlendModeDarken:暗化混合模式通过选择前景图片与背景图片更暗的采样来混合图片采样。背景图片采样被前景图片采样更暗的部分取代，而其它部分不变。
     *  kCGBlendModeLighten:亮化混合模式通过选择前景图片与背景图片更亮的采样来混合图片采样。背景图片采样被前景图片采样更亮的部分取代，而其它部分不变。
     *  kCGBlendModeColorDodge:色彩减淡模式加亮背景图片采样以反映出前景图片采样。被指定为黑色的前景图片采样值将不产生变化。
     *  kCGBlendModeColorBurn:色彩加深模式加深背景图片采样以反映出前景图片采样。被指定为白色的前景图片采样值将不产生变化。
     *  kCGBlendModeSoftLight:柔光混合模式根据前景采样颜色减淡或加深颜色值。如果前景采样颜色比50%灰度值更亮，则减淡背景，类似于Dodge模式。如果前景采样颜色比50%灰度值更暗，则加强背景，类似于Burn模式。纯黑或纯白的图片采样将产生更暗或更亮的区域。但是但是不产生纯白或纯黑的颜色。该效果类似于将一个漫射光源放于一个前景图前。该效果用于在场景中添加高光效果。
     *  kCGBlendModeHardLight:强光混合模式根据前景图片采样颜色正片叠加或屏幕化颜色。如果前景采样颜色比50%灰度值更亮，则减淡背景，类似于screen模式。如果前景采样颜色比50%灰度值更暗，则加深背景，类似于multiply模式。如果前景采样颜色等于50%灰度，则前景颜色不变。纯黑与纯白的颜色图片采样将产生纯黑或纯白的颜色值。该效果类似于将一个强光源放于一个前景图前。该效果用于在场景中添加高光效果。图3-24显示了混合效果。
     *  kCGBlendModeDifference:差值混合模式将前景图片采样颜色值与背景图片采样值相减，相减的前后关系取决于哪个采样的亮度值更大。黑色的前景采样值不发生变化；白色值转化为背景的值。
     *  kCGBlendModeExclusion:排除混合模式，该效果类似于Difference效果，只是对比度更低。黑色的前景采样值不发生变化；白色值转化为背景的值。
     *  kCGBlendModeHue:色相混合模式，使用背景的亮度和饱和度与前景的色相混合。
     *  kCGBlendModeSaturation:饱和度混合模式，混合背景的亮度和色相前景的饱和度。背景中没有饱和度的区域不发生变化。
     *  kCGBlendModeColor:颜色混合模式，混合背景的亮度值与前景的色相与饱和度。该模式保留图片的灰度级。我们可以使用该模式绘制单色图片或彩色图片。
     *  kCGBlendModeLuminosity:亮度混合模式将背景图片的色相、饱和度与背景图片的亮度相混合。该模块产生一个与Color Blend模式相反的效果。
     */
    CGContextSetBlendMode(context, self.blendMode);
    
    CGContextRestoreGState(context);
}

#pragma mark - 笛卡尔心形线 -
- (void)drawCardiod
{
    NSInteger i = 0;
    switch (i) {
        case 0:
        {
            break;
        }
        default:
            break;
    }
}

- (void)cardiodFunction1
{
    //笛卡尔 心形线
    /**
     *
     *  直角坐标系方程 (x^2+y^2-2*a*x)^2=4*a^2*(x^2+y^2)
     *  极坐标方程 r=2*a*(1+cos(theta))
     *  参数方程   x=a*(2*cos(t)-cos(2*t)),
     y=a*(2*sin(t)-sin(2*t))
     
     */
    //获取图形的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x = self.bounds.size.width / 2;
    CGFloat y = self.bounds.size.height / 2;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x, y);
    for (float i=0;i<=20;i=i+0.01)
    {
        //产生极坐标点
        x=16*pow(sin(i), 3) + 100;
        y=13*cos(i) - 5*cos(2*i) - 2*cos(3*i) - cos(4*i) + 100;
        NSLog(@"x=%f,y=%f",x,y);
        if (i !=0)
        {
            CGContextAddLineToPoint(context, x, y);
        }
    }
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

- (void)cardiodFunction2
{
    /**
     *  桃心2
     *  x = 16*(sit(t))3
     *  y = 13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t)
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x = self.bounds.size.width / 2;
    CGFloat y = self.bounds.size.height / 2;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x, y);
    for (float i=0;i<=20;i=i+0.01)
    {
        //产生极坐标点
        x=16*pow(sin(i), 3) + 100;
        y=13*cos(i) - 5*cos(2*i) - 2*cos(3*i) - cos(4*i) + 100;
        NSLog(@"x=%f,y=%f",x,y);
        if (i !=0)
        {
            CGContextAddLineToPoint(context, x, y);
        }
    }
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

- (void)cardiodFunction3
{
    //桃心1
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x = self.bounds.size.width / 2;
    CGFloat y = self.bounds.size.height / 2;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x, y);
    float m,n;float i;
    for (i=0;i<=200;i=i+0.01)
    {
        //产生极坐标点
        m=i;
        n=-50*(((sin(i)*sqrt(fabs(cos(i))))/(sin(i)+1.4))-2*sin(i)+2);
        //转换为笛卡尔坐标
        x=n*cos(m)+200;
        y=n*sin(m)+150;
        NSLog(@"x=%f,y=%f",x,y);
        if (i !=0)
        {
            CGContextAddLineToPoint(context, x, y);
        }
    }
    CGContextStrokePath(context);
    CGContextClosePath(context);

}


@end
