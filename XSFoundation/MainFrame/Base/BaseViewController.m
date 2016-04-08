//
//  BaseViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "BaseViewController.h"
#import "UIBarButtonItem+NaviItem.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  统一配置
     *  1.背景色
     *  2.LeftBtn
     */
    self.view.backgroundColor = Color_BG;
    if (self.navigationController.childViewControllers.count > 1) {
        [self defaultLeftBackButton];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)defaultLeftBackButton {
    UIImage *backImage = [UIImage imageNamed:@"nav_back_nor.png"];
    UIBarButtonItem *leftBarItem = [UIBarButtonItem itemWidth:60
                                                        image:backImage
                                               imageHighlight:backImage
                                                        title:nil
                                                   titleColor:nil
                                                       target:self
                                                       action:@selector(leftBackButtonClicked)
                                                       offset:CGPointMake(-23, 0)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)leftBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
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
