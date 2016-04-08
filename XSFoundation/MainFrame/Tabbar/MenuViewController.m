//
//  MenuViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "MenuViewController.h"
#import "OCFoundationViewController.h"
#import "UIFoundationViewController.h"
#import "AnimationViewController.h"
#import "ThirdPartyViewController.h"
#import "BaseNavigationViewController.h"
#import "UITabBarItem+Custom.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initViewControlers];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViewControlers
{
    OCFoundationViewController *ocFoundationVC = [[OCFoundationViewController alloc] init];
    BaseNavigationViewController *ocFoundationNaviVC = [[BaseNavigationViewController alloc] initWithRootViewController:ocFoundationVC];
    ocFoundationNaviVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"OC基础"
                                                                     image:[[UIImage imageNamed:@"tabbar_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             selectedImage:[[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] custom:YES];
    
    UIFoundationViewController *uiFoundationVC = [[UIFoundationViewController alloc] init];
    BaseNavigationViewController *uiFoundationNaviVC = [[BaseNavigationViewController alloc] initWithRootViewController:uiFoundationVC];
    uiFoundationNaviVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"UI基础"
                                                                     image:[[UIImage imageNamed:@"tabbar_schedule_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             selectedImage:[[UIImage imageNamed:@"tabbar_schedule_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] custom:YES];
    
    AnimationViewController *animateVC = [[AnimationViewController alloc] init];
    BaseNavigationViewController *animateNaviVC = [[BaseNavigationViewController alloc] initWithRootViewController:animateVC];
    animateNaviVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Animate基础"
                                                                    image:[[UIImage imageNamed:@"tabbar_service_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                            selectedImage:[[UIImage imageNamed:@"tabbar_service_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] custom:YES];
    
    ThirdPartyViewController *thirdVC = [[ThirdPartyViewController alloc] initWithNibName:nil bundle:nil];
    BaseNavigationViewController *thirdNaviVC = [[BaseNavigationViewController alloc] initWithRootViewController:thirdVC];
    thirdNaviVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"第三方运用"
                                                          image:[[UIImage imageNamed:@"tabbar_lock_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                  selectedImage:[[UIImage imageNamed:@"tabbar_lock_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] custom:YES];
    self.viewControllers = @[ocFoundationNaviVC,
                             uiFoundationNaviVC,
                             animateNaviVC,
                             thirdNaviVC];
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
