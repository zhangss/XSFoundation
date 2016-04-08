//
//  OCFoundationViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "OCFoundationViewController.h"
#import "NumberViewController.h"

@interface OCFoundationViewController ()

@end

@implementation OCFoundationViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        SimpleModel *model = [[SimpleModel alloc] init];
        model.title = @"String-->Price Number";
        model.data = NSStringFromClass([NumberViewController class]);
        [self.tableData addObject:model];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"OC基础";
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
