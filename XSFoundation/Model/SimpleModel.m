//
//  SimpleModel.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "SimpleModel.h"

@implementation SimpleModel

+ (SimpleModel *)simpleModel:(NSString *)title
                            :(id)data
{
    SimpleModel *model = [[SimpleModel alloc] init];
    model.title = title;
    model.data = data;
    return model;
}

@end
