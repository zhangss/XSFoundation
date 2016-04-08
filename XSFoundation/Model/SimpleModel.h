//
//  SimpleModel.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) id data;

/**
 *  便捷方法
 *
 *  @param title 显示使用的Title
 *  @param data  title对应的数据
 *
 *  @return
 */
+ (SimpleModel *)simpleModel:(NSString *)title
                            :(id)data;

@end
