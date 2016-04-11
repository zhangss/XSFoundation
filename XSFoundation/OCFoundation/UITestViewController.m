//
//  UITestViewController.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/11.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "UITestViewController.h"

@interface UITestViewController ()

@end

@implementation UITestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"UITest";
    
    self.registerButton.accessibilityIdentifier = @"registerButtonIdentifier";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender
{
    if (sender == self.loginButton) {
        self.showLabel.text = self.loginField.text;
    }else if (sender == self.registerButton) {
        self.showLabel.text = self.registerField.text;
    }
}

- (void)displayShow {
    self.textView.text = @"This is textView test!";
    self.imageIV.image = [UIImage imageNamed:@"tabbar_home_selected"];
}

@end
