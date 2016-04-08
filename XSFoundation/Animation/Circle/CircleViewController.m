//
//  CircleViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "CircleViewController.h"
#import "SegmentWithColorSlider.h"
#import "CircleView.h"

@interface CircleViewController ()

@property (nonatomic, strong) CircleView *circleView;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Circle Layer";
    // Do any additional setup after loading the view.

//    //开始图像绘图
//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    //获取当前CGContextRef
//    CGContextRef gc = UIGraphicsGetCurrentContext();
//
//    //使用CGContextTranslateCTM函数来转移坐标的Transform，这样我们不用按照实际显示做坐标计算
//    CGContextTranslateCTM(gc, 50, 50);
//    //左眼
//    CGContextAddEllipseInRect(gc, CGRectMake(0, 0, 20, 20));
//    //右眼
//    CGContextAddEllipseInRect(gc, CGRectMake(80, 0, 20, 20));
//    //笑
//    CGContextMoveToPoint(gc, 100, 50);
//    CGContextAddArc(gc, 50, 50, 50, 0, M_PI, NO);
//    //设置绘图属性
//    [[UIColor blueColor] setStroke];
//    CGContextSetLineWidth(gc, 2);
//    //执行绘画
//    CGContextStrokePath(gc);
//    
//    //从Context中获取图像，并显示在界面上
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//    [self.view addSubview:imgView];
    
    
    //关键帧动画
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    //设置path属性
//    UIBezierPath *circlePath = [UIBezierPath bezierPath];
//    [circlePath addArcWithCenter:self.circleCenter
//                          radius:self.radius
//                      startAngle:self.startAngle
//                        endAngle:self.endAngle
//                       clockwise:NO];
//    [animation setPath:[circlePath CGPath]];
//    [animation setDuration:3.0f];
//    //这句代码表示 是否动画回到原位
//    //[animation setAutoreverses:YES];
//    animation.calculationMode = kCAAnimationLinear;
//    animation.rotationMode = kCAAnimationRotateAuto;
//    [self.indicatorLayer addAnimation:animation forKey:NULL];
    
    //分段控制器
    [self initSegmetSligderView];
}

- (void)initSegmetSligderView
{
    CGRect segmentRect = CGRectMake(CGPointZero.x,
                                    CGPointZero.y,
                                    SCREEN_SIZE.width,
                                    45);
    SegmentWithColorSlider *segmentedControl = [[SegmentWithColorSlider alloc]
                             initWithFrame:segmentRect
                             titles:@[@"原始圆形", @"半圆", @"渐变进度条"]];
    segmentedControl.font = [UIFont systemFontOfSize:16.0f];
    segmentedControl.textColor = [UIColor blackColor];
    segmentedControl.indicatorColor = Color_Navi;
    segmentedControl.indicatorHeight = 3.0;
    segmentedControl.indicatorWidth = COMMON_VI_10 * 9;
    segmentedControl.indicatorPositionY = segmentRect.size.height - segmentedControl.indicatorHeight;
    segmentedControl.selectedIndex = 0;//设置默认选择项索引
    [segmentedControl addTarget:self action:@selector(segmentAction:)
                forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

- (void)segmentAction:(SegmentWithColorSlider *)seg
{
    NSInteger index = seg.selectedIndex;
    if (index == 0)
    {
        [self.circleView removeFromSuperview];
        self.circleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_SIZE.width, SCREEN_SIZE.height - 64 - 45)];
        [self.view addSubview:self.circleView];
        [self.circleView originalCircle];
    }
    else if (index == 1)
    {
        [self.circleView removeFromSuperview];
        self.circleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_SIZE.width, SCREEN_SIZE.height - 64 - 45)];
        [self.view addSubview:self.circleView];
        [self.circleView halfCircle];
    }
    else if (index == 2)
    {
        [self.circleView setPercent:0.9];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
