//
//  ExampleUITests.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/8.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import <XCTest/XCTest.h>

/**
 *  XCode7开始提供，可以测试UI
 */

/**
 *  使用：
 *  1.光标放到某个测试方法内
 *  2.点击下方控制台工具栏上的红色按钮，程序启动自动
 *  3.录制UI操作：操作APP的UI，单元测试代码会自动添加到测试方法内。
 *
 */

@interface ExampleUITests : XCTestCase

@end

@implementation ExampleUITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testUIA {
    
    //XCUIApplication 这是应用的代理，他能够把你的应用启动起来，并且每次都在一个新进程中。
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"String-->Price Number"] tap];
    [[[app.navigationBars[@"Price-Number"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:1] tap];
    
    //XCUIElement 这是 UI 元素的代理。元素都有类型和唯一标识。可以结合使用来找到元素在哪里，如当前界面上的一个输入框
    XCUIElement *usernameTextField = app.textFields[@"username:"];
    [usernameTextField tap];
    [usernameTextField typeText:@"xiaofei"];

    XCUIElement *button = [[app.navigationBars[@"Price-Number"] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:1];
    [button tap];
    
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    
    XCTAssertEqualObjects(app.navigationBars.element.identifier, @"loginSuccess");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
