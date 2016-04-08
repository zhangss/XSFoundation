//
//  AnimationViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "AnimationViewController.h"
#import "QuartZViewController.h"
#import "GradientViewController.h"
#import "CircleViewController.h"
#import "AnimateCollectionViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        SimpleModel *model = [[SimpleModel alloc] init];
        model.title = @"渐变色";
        model.data = NSStringFromClass([GradientViewController class]);
        [self.tableData addObject:model];

        model = [[SimpleModel alloc] init];
        model.title = @"心形线";
        model.data = NSStringFromClass([QuartZViewController class]);
        [self.tableData addObject:model];
        
        model = [[SimpleModel alloc] init];
        model.title = @"圆";
        model.data = NSStringFromClass([CircleViewController class]);
        [self.tableData addObject:model];
        
        model = [[SimpleModel alloc] init];
        model.title = @"小动画";
        model.data = NSStringFromClass([AnimateCollectionViewController class]);
        [self.tableData addObject:model];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Animate基础";
    // Do any additional setup after loading the view from its nib.
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
