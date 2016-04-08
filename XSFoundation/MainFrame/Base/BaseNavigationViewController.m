//
//  BaseNavigationViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UINavigationBar定制
    //是否透明
    self.navigationBar.translucent = NO;
    //UINavigationBar颜色
    self.navigationBar.barTintColor = Color_Navi;
    //UINavigationBar标题颜色
    self.navigationBar.titleTextAttributes =
  @{NSForegroundColorAttributeName: [UIColor whiteColor],
    NSFontAttributeName: [UIFont systemFontOfSize:20]};

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
