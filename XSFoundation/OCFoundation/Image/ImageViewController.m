//
//  ImageViewController.m
//  XSFoundation
//
//  Created by 张松松 on 16/8/29.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageCompressionViewController.h"
@interface ImageViewController ()

@end

@implementation ImageViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        SimpleModel *model = [[SimpleModel alloc] init];
        model.title = @"ImageCompression";
        model.data = NSStringFromClass([ImageCompressionViewController class]);
        [self.tableData addObject:model];        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Image About";
    // Do any additional setup after loading the view.
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
