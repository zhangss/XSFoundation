//
//  NSNumber+Price.m
//  XSFoundation
//
//  Created by 张松松 on 15/12/26.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "NSNumber+Price.h"

@implementation NSNumber (Price)

- (NSString *)priceDecimalStringValue
{
    return [self priceStringValue:2];
}

/**
 *  金额字符串，控制小数点位数
 *
 *  @param decimalPlaces 小数点位数
 *
 *  @return
 */
- (NSString *)priceStringValue:(NSUInteger)decimalPlaces
{
    NSNumber *price = @(self.doubleValue / 100);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    //金额除以100取余，如果余数大于0则显示2位小数；如果余数等于0则显示整数
    if (self.longValue % 100 == 0) {
        decimalPlaces = 0;
    }else{
        decimalPlaces = 2;
    }
    formatter.minimumFractionDigits = decimalPlaces;
    formatter.maximumFractionDigits = decimalPlaces;
    formatter.groupingSize = 3;
    formatter.groupingSeparator = @"";
    NSString *result = [formatter stringFromNumber:price];
    return result;
}

+ (NSDecimalNumber *)priceDecimalFromString:(NSString *)price
{
    NSDecimalNumber *multiply = [[NSDecimalNumber alloc] initWithInteger:100];
    NSDecimalNumber *yuanNumber = [NSDecimalNumber decimalNumberWithString:price];
    NSDecimalNumber *fenNumber = [yuanNumber decimalNumberByMultiplyingBy:multiply];
    return fenNumber;
}

+ (NSDecimalNumber *)priceDecimalFromString:(NSString *)price
                                 byMultiply:(NSDecimalNumber *)multiply
{
    NSDecimalNumber *yuanNumber = [NSDecimalNumber decimalNumberWithString:price];
    NSDecimalNumber *multiplyNumber = [yuanNumber decimalNumberByMultiplyingBy:multiply];
    multiply = [[NSDecimalNumber alloc] initWithInteger:100];
    NSDecimalNumber *fenNumber = [multiplyNumber decimalNumberByMultiplyingBy:multiply];
    return fenNumber;
}

@end
