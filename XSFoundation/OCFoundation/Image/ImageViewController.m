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
    
    NSString *ch = @"123@!abcd中文";
    NSString *encode = [ch stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeTwice = [encode stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeThree = [encodeTwice stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"0:%@",ch);
    NSLog(@"1:%@",encode);
    NSLog(@"2:%@",encodeTwice);
    NSLog(@"3:%@",encodeThree);
    NSString *decode = [encodeThree stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *decodeTwice = [decode stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *decodeThree = [decodeTwice stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"2:%@",decode);
    NSLog(@"1:%@",decodeTwice);
    NSLog(@"0:%@",decodeThree);
    
    NSString *urlStr = @"www.baidu.com/图片";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"中文url:%@ String:%@",url,urlStr);
    NSString *urlEncode = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:urlEncode];
    NSLog(@"中文编码url:%@ String:%@",url,urlEncode);
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
