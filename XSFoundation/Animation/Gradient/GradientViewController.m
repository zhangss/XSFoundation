//
//  GradientViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/17.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "GradientViewController.h"
#import "PropertySelectorsView.h"
#import "GradientView.h"
#import "SimpleModel.h"

@interface GradientViewController ()

@property (nonatomic, strong) GradientView *gradientView;
@property (nonatomic, strong) PropertySelectorsView *propView;

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"渐变色";
    // Do any additional setup after loading the view from its nib.
    
    //动画
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(showAnimation)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self showGradientPropertySimulateView];
}

#pragma mark -
#pragma mark 渐变属性配置
- (void)showGradientPropertySimulateView
{
    //属性选择View
    self.propView = [self addPropertySelectorsView];
    [self.view addSubview:self.propView];
    CGRect frame = self.propView.frame;
    frame.origin.y = VIEW_HEIGHT - frame.size.height;
    self.propView.frame = frame;
    
    //结果显示View
    frame.origin.x = COMMON_VI_10;
    frame.origin.y = COMMON_VI_10;
    frame.size.width = SCREEN_SIZE.width - COMMON_VI_10 * 2;
    frame.size.height = VIEW_HEIGHT - frame.size.height - COMMON_VI_10 * 2;
    self.gradientView = [[GradientView alloc] initWithFrame:frame];
    [self.view addSubview:self.gradientView];
}

/**
 *  属性选择View
 */
- (PropertySelectorsView *)addPropertySelectorsView
{
    NSMutableArray *allProps = [NSMutableArray arrayWithCapacity:5];
    
    //起始点/结束点属性
    NSArray *ponits = [NSArray arrayWithObjects:
                       [SimpleModel simpleModel:@"(0,0)" :NSStringFromCGPoint(CGPointMake(0, 0))],
                       [SimpleModel simpleModel:@"(0,1)" :NSStringFromCGPoint(CGPointMake(0, 1))],
                       [SimpleModel simpleModel:@"(1,0)" :NSStringFromCGPoint(CGPointMake(1, 0))],
                       [SimpleModel simpleModel:@"(1,1)" :NSStringFromCGPoint(CGPointMake(1, 1))],
                       nil];
    SimpleModel *startPointModel =
    [SimpleModel simpleModel:@"startPoint："
                            :ponits];
    SimpleModel *endPointModel =
    [SimpleModel simpleModel:@"endPoint："
                            :ponits];
    [allProps addObject:startPointModel];
    [allProps addObject:endPointModel];
    
    //位置集合属性
    NSArray *locationEmpty = nil;
    NSArray *secondAverageLocation = [NSArray arrayWithObjects:
                                      [NSNumber numberWithInt:0],
                                      [NSNumber numberWithInt:1],
                                      nil];
    NSArray *thirdAverageLocation = [NSArray arrayWithObjects:
                                     [NSNumber numberWithInt:0],
                                     [NSNumber numberWithFloat:0.5],
                                     [NSNumber numberWithInt:1],
                                     nil];
    NSArray *thirdLocation = [NSArray arrayWithObjects:
                              [NSNumber numberWithInt:0],
                              [NSNumber numberWithFloat:0.3],
                              [NSNumber numberWithInt:1],
                              nil];
    SimpleModel *propLocationsModel =
    [SimpleModel simpleModel:@"Locations："
                            :[NSArray arrayWithObjects:
                              [SimpleModel simpleModel:@"无(nil)" :locationEmpty],
                              [SimpleModel simpleModel:@"(0,1)" :secondAverageLocation],
                              [SimpleModel simpleModel:@"(0,0.5,1)" :thirdAverageLocation],
                              [SimpleModel simpleModel:@"(0,0.3,1)" :thirdLocation],
                              nil]];
    [allProps addObject:propLocationsModel];
    
    //颜色集合属性
    NSArray *RBColors = [NSArray arrayWithObjects:
                         (id)[UIColor redColor].CGColor,
                         (id)[UIColor blueColor].CGColor,
                         nil];
    NSArray *RGBColors = [NSArray arrayWithObjects:
                          (id)[UIColor redColor].CGColor,
                          (id)[UIColor greenColor].CGColor,
                          (id)[UIColor blueColor].CGColor,
                          nil];
    SimpleModel *propColorsModel =
    [SimpleModel simpleModel:@"Colors："
                            :[NSArray arrayWithObjects:
                              [SimpleModel simpleModel:@"R/B"   :RBColors],
                              [SimpleModel simpleModel:@"R/G/B" :RGBColors],
                              nil]];
    [allProps addObject:propColorsModel];
    
    //实现方式
    SimpleModel *implementTypeModel =
    [SimpleModel simpleModel:@"实现方式："
                            :[NSArray arrayWithObjects:
                              [SimpleModel simpleModel:@"CALayer" :IntegerToString(kGradientIMPCALayer)],
                              [SimpleModel simpleModel:@"GradientRef" :IntegerToString(kGradientIMPCGGradientRef)],
                              [SimpleModel simpleModel:@"ShadingRef" :IntegerToString(kGradientIMPCGShadingRef)],
                              [SimpleModel simpleModel:@"CoreImage" :IntegerToString(kGradientIMPCoreImage)],
                              nil]];
    [allProps addObject:implementTypeModel];
    
    //渐变类型
    SimpleModel *gradientTypeModel =
    [SimpleModel simpleModel:@"渐变类型："
                            :[NSArray arrayWithObjects:
                              [SimpleModel simpleModel:@"线性(Linear)" :IntegerToString(kGradientLinear)],
                              [SimpleModel simpleModel:@"辐射(Radial)" :IntegerToString(kGradientRadial)],
                              [SimpleModel simpleModel:@"轴向(Axial)" :IntegerToString(kGradientAxial)],
                              nil]];
    [allProps addObject:gradientTypeModel];
    
    //渐变范围
    SimpleModel *gradientRangeModel =
    [SimpleModel simpleModel:@"渐变范围："
                            :[NSArray arrayWithObjects:
                              [SimpleModel simpleModel:@"正方形" :@"0"],
                              [SimpleModel simpleModel:@"多边形" :@"1"],
                              [SimpleModel simpleModel:@"渐变"   :@"2"],
                              nil]];
    [allProps addObject:gradientRangeModel];
    
    PropertySelectorsView *propView = [[PropertySelectorsView alloc] initWithSelectors:allProps];
    
    __weak __typeof(self) safeSelf = self;
    propView.selectorResult = ^(NSInteger index,NSArray *result){
        //属性变化
        SimpleModel *model = [result objectAtIndex:index];
        switch (index) {
            case 0:
            {
                [safeSelf.gradientView setStartPoint:CGPointFromString(model.data)];
                break;
            }
            case 1:
            {
                [safeSelf.gradientView setEndPoint:CGPointFromString(model.data)];
                break;
            }
            case 2:
            {
                [safeSelf.gradientView setLocations:model.data];
                break;
            }
            case 3:
            {
                [safeSelf.gradientView setColors:model.data];
                break;
            }
            case 4:
            {
                [safeSelf.gradientView setImpType:[model.data integerValue]];
                break;
            }
            case 5:
            {
                [safeSelf.gradientView setType:[model.data integerValue]];
                break;
            }
            case 6:
            {
                [safeSelf.gradientView gradientRange:[model.data integerValue]];
                break;
            }
            default:
                break;
        }
    };
    return propView;
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

#pragma mark -
#pragma mark Animation
- (void)showAnimation
{
    [self.gradientView showAnimation];
}

@end
