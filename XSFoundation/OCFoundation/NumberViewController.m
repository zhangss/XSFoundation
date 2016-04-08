//
//  NumberViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/12/26.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "NumberViewController.h"
#import "NSNumber+Price.h"

@interface NumberViewController ()

@property (nonatomic, strong) NSMutableArray *numberStrings;
@property (nonatomic, strong) NSMutableArray *numbers;

@end

@implementation NumberViewController

@synthesize numberStrings;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Price-Number";
    // Do any additional setup after loading the view from its nib.
    numberStrings = [NSMutableArray arrayWithCapacity:10];
    [numberStrings addObject:@"0"];
    [numberStrings addObject:@"1"];
    [numberStrings addObject:@"10"];
    [numberStrings addObject:@"100"];
    [numberStrings addObject:@"01"];
    [numberStrings addObject:@"001"];

    [numberStrings addObject:@"0.0"];
    [numberStrings addObject:@"0.00"];
    [numberStrings addObject:@"0.1"];
    [numberStrings addObject:@"0.10"];
    [numberStrings addObject:@"0.11"];
    [numberStrings addObject:@"0.01"];
    [numberStrings addObject:@"00.01"];

    [numberStrings addObject:@"1.0"];
    [numberStrings addObject:@"1.00"];
    [numberStrings addObject:@"1.10"];
    [numberStrings addObject:@"1.01"];

    [numberStrings addObject:@"999999999.99"];
    
    
    self.numbers = [NSMutableArray arrayWithCapacity:[numberStrings count]];
    
    [self deciamlNumber];
    
    NSComparisonResult result = [[NSNumber numberWithInteger:1] compare:[NSNumber numberWithInteger:1]];
    result = [[NSNumber numberWithInteger:1.0] compare:[NSNumber numberWithInteger:1]];
    result = [[NSNumber numberWithInteger:1.0] compare:[NSNumber numberWithInteger:2]]; //NSOrderedAscending
    
}

- (void)deciamlNumber
{
    NSLog(@"String-->Price-->String");
    for (NSString *numberStr in numberStrings)
    {
        NSNumber *price = [NSNumber priceDecimalFromString:numberStr];
        NSString *priceString = [price priceDecimalStringValue];
        NSLog(@"%@-->%@-->%@-->%@",numberStr,price,priceString,price.stringValue);
        
        [_numbers addObject:price];
    }
    
    NSLog(@"Number--int--integer--Long--LongLong");
    for (NSNumber *number in self.numberStrings)
    {
        NSLog(@"%@--%d--%ld",number,[number intValue],[number integerValue]);
    }
    
    
    NSLog(@"Number--float--double");
    for (NSNumber *number in self.numberStrings)
    {
        NSLog(@"%@--%f--%f",number,[number floatValue],[number doubleValue]);
    }
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
