//
//  ExampleTests.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/8.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <XCTest/XCTest.h>

/**
 *  Xcode4.x使用OCUnit,Xcode5之后改为XCTest
 *  GHUnit,KiWi，OCMock,Specta
 *
 *
 *  官方例子：https://developer.apple.com/library/mac/samplecode/UnitTests/Introduction/Intro.html
 *  参考：http://www.tuicool.com/articles/jUrqiqR
 */

/**
 *  XCTest/XCTest.h not found
 *  测试文件只能被包含在测试target中
 */

/**
 *  单元测试注意点:
 *  1.测试用例方法必须以test开头，返回值为Void
 *    点击方法左边菱形进行测试，或者左侧到导航的菱形显示所有测试类，可以总览。
 *  2.如果测试整个文件的所有方法，单元测试会按照字母顺序依次进行，断点使用testInvocations可以查看执行的用例列表。
 *    点击类名附近的菱形，测试整个文件；Target名称之后的菱形，测试整个Target；
 *  3.单元测试单线程，如果测试异步操作请保持线程，等异步回调之后才能结束，否则异步无法完整执行。
 *  4.使用XCTAssert...断言来提示用例执行结果。
 *  5.断言与是XCTestExpectation两码事，两者都可以表示测试结果。
 *  6.快捷键CMD+U测试所有Target测试用例。CMD+5切换到单元测的导航栏
 */

@interface ExampleTests : XCTestCase

@end

@implementation ExampleTests

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

- (void)testMethodC {
    XCTAssert(YES,@"通用断言");
}

- (void)testMethodB {
    XCTFail(@"用例测试失败");
}

#pragma mark -
#pragma mark 异步单元测试
/**
 *  异步单元测试
 *  A:异步线程
 *  B:异步等待
 *  C:
 */
- (void)testMethodAsyncA {
    //定义之后，只有fulfill，用例才算通过，否则认为失败
    XCTestExpectation *exp = [self expectationWithDescription:@"异步用例测试失败"];

    NSInteger excuteTime = 1;  //成功
//    NSInteger excuteTime = 2;  //等待超时失败
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(excuteTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        code to be executed after a specified delay
        //断言检查结果
        XCTAssertTrue(YES);
        //宣布测试结果满足
        [exp fulfill];
    });
    
    //阻塞等待1s，期间如果没执行出正确的结果则不通过。此处已经开始阻塞测试主线程。
    NSTimeInterval waitTime = 1.0f;
    [self waitForExpectationsWithTimeout:waitTime handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"异步等待超时:error:%@",error);
        }
    }];
}

/**
 *  谓词法NSPredicate
 *  TODO:不理解
 */
- (void)testMethodAsyncB {
    NSString *testString = @"1";
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        //循环执行，直到YES
        //此处应该放异步执行的Code
        for (NSInteger i = 0; i < 10000; i++) {
            NSLog(@"%ld",i);
        }
        return YES;
    }];
    
    /**
     * Creates an expectation that is fulfilled if the predicate returns true when evaluated with the given
     * object. The expectation periodically evaluates the predicate and also may use notifications or other
     * events to optimistically re-evaluate.
     * 初始化一个Expectation对象，当predicate返回YES时自动fulfilled。
     * expectation对象会定期检查谓词结果直到返回YES。中间可以用通知等重新检查。
     * handle可以为nil
     */
    [self expectationForPredicate:predicate
              evaluatedWithObject:testString
                          handler:^BOOL{
                              //predicate返回YES之后的，执行
                              XCTAssert([testString isEqualToString:@"1"]);
                              
                              //返回YES结束用例，返回NO循环执行。
                              return NO;
                          }];
    
    NSTimeInterval waitTime = 1.0f;
    [self waitForExpectationsWithTimeout:waitTime handler:nil];
}

/**
 *  通知法NSNotification，适用于包含通知输出的异步单元测试
 *  TODO:不理解
 */
- (void)testMethodAsyncC {
    
    NSString *notificationName = @"success";
    [self expectationForNotification:notificationName
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
        //返回结果
        return YES;
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                        object:nil];
    
    NSTimeInterval waitTime = 10.0f;
    [self waitForExpectationsWithTimeout:waitTime handler:nil];
}

#pragma mark -
#pragma mark 性能测试
//TODO:性能测试不会玩
- (void)testPerformanceExample {
    //性能测试...评估一段代码的运行时间
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

/**
 *  性能测试：
 *  用于测试一组方法的执行时间，通过设置baseline（基准）和MAX stddev（标准偏差）来判断方法是否能通过性能测试
 *  性能测试会循环多次执行代码，给出平均执行耗时，然后比对基础得到偏差，来判断是否通过。
 */
//- (void)testMethodPerformanceA {
//    [self measureBlock:^{
//        for (NSInteger i = 0; i < 10000; i++) {
//            NSLog(@"%ld",i);
//        }
//    }];
//}

@end
