//
//  UITestViewController.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/11.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "BaseViewController.h"

@interface UITestViewController : BaseViewController

@property (nonatomic, strong) IBOutlet UILabel *showLabel;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet UITextField *loginField;
@property (nonatomic, strong) IBOutlet UIButton *registerButton;
@property (nonatomic, strong) IBOutlet UITextField *registerField;
@property (nonatomic, strong) IBOutlet UIImageView *imageIV;
@property (nonatomic, strong) IBOutlet UITextView *textView;

- (IBAction)buttonClicked:(id)sender;

- (void)displayShow;

@end
