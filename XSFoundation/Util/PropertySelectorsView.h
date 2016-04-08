//
//  PropertySelectorsView.h
//  XSFoundation
//
//  Created by 张松松 on 15/11/17.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectorResult)(NSInteger index, NSArray *results);

@interface PropertySelectorsView : UIView

@property (nonatomic, strong) NSMutableArray<SimpleModel *> *results;

@property (nonatomic, strong) SelectorResult selectorResult;

- (PropertySelectorsView *)initWithSelectors:(NSArray<SimpleModel *> *)data;

@end
