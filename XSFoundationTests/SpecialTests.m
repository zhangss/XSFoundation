//
//  SpecialTests.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/8.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "SpecialTests.h"

@implementation SpecialTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //测试方法执行之前...
    //1.做一些初始化话配置操作
}

- (void)tearDown {
    //测试方法执行之后...
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testMethodA {
    XCTAssertTrue(YES,@"用例测试成功");
}

- (void)testPerformanceExample {
    //性能测试...评估一段代码的运行时间
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
