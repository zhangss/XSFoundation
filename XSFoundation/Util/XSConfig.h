//
//  XSConfig.h
//  XSFoundation
//
//  Created by 张松松 on 16/8/29.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSConfig : NSObject

/**
 *  单例
 *
 *  @return 
 */
+ (XSConfig *)shareConfig;

#pragma mark - File System -
/**
 *  图片压缩测试目录
 *
 *  @return
 */
- (NSString *)imageCompressionPath;

@end
