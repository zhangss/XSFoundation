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

@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation ExampleUITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //XCUIApplication 这是应用的代理，他能够把你的应用启动起来，并且每次都在一个新进程中。
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];//启动
//    [self.app terminate];//中止
    
//    self.continueAfterFailure = NO;
    
    /**
     *  APP的启动参数配置
     *  TODO:可以配置什么？
     */
//    NSArray *launchArgs = self.app.launchArguments;
//    NSLog(@"launchArgs:%@",launchArgs);
    
    /**
     *  APP的运行配置
     *  TODO:可以配置什么？
     */
//    NSDictionary *launchEnvConfig = self.app.launchEnvironment;
//    NSLog(@"launchEnvs:%@",launchEnvConfig);
    
    /**
     *  单元测试的运行信息
     */
//    NSLog(@"appInfo:%@",[self.app debugDescription]);
    
    /**
     *  使用XCUIElementQuery查询元素节点
     */
    //    XCUIElementQuery *tables = self.app.tables;
    //    XCUIElementQuery *tables = [self.app descendantsMatchingType:XCUIElementTypeTable];

    //    XCUIElementQuery *staticTexts = tables.staticTexts;
    /**
     *  Keyed subscripting is implemented as a shortcut for matching an identifier only. For example, app.descendants["Foo"] -> XCUIElement
     */
    //    XCUIElement *targetElement = [staticTexts objectForKeyedSubscript:@"UITest"];
    //    [targetElement tap];
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
    //进入测试页面
    [self.app.tables.staticTexts[@"UITest"] tap];
    
    //通过页面UI检索
    XCUIElement *showLabel = self.app.staticTexts[@"showLabelContent"];
    //文本查询 全写
//    showLabel = [self.app.staticTexts objectForKeyedSubscript:@"showLabelContent"];
    //Accessibility identifier
//    showLabel = [self.app.staticTexts objectForKeyedSubscript:@"showLabelIdentifier"];
    [self checkElementInfo:showLabel];
    XCTAssertTrue([showLabel.label isEqualToString:@"showLabelContent"]);
    
    XCUIElement *loginButton = self.app.buttons[@"login"];
//    loginButton = [self.app.buttons objectForKeyedSubscript:@"loginButtonIdentifier"];
    [loginButton tap];
    [self checkElementInfo:loginButton];
    [self checkElementInfo:showLabel];
    XCTAssertTrue([showLabel.label isEqualToString:@"loginFieldContent"]);
    
    XCUIElement *registerButton = self.app.buttons[@"registerButtonIdentifier"];
    [registerButton tap];
    [self checkElementInfo:registerButton];
    XCTAssertTrue([showLabel.label isEqualToString:@"registerFieldContent"]);
}

- (void)testUIB {
    //进入测试页面
    [self.app.tables.staticTexts[@"UITest"] tap];
    XCUIElement *showLabel = self.app.staticTexts[@"showLabel"];
//    XCUIElement *imageIV = self.app.images[@"imageView"];
//    XCUIElement *textView = self.app.textViews[@"textView"];
    
    XCUIElement *loginButton = self.app.buttons[@"login"];
    [loginButton tap];
    //输入
    XCUIElement *loginField = self.app.textFields[@"loginField"];
    [loginField tap];
    [loginField typeText:@"loginTest"];
    //刷新显示
    [loginButton tap];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        XCUIElement *label = evaluatedObject;
        return [label.label rangeOfString:@"loginTest"].location != NSNotFound;
    }];
    [self expectationForPredicate:predicate evaluatedWithObject:showLabel handler:nil];
    [self waitForExpectationsWithTimeout:3.0f handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)checkElementInfo:(XCUIElement *)element {
    /*! Test to determine if the element exists. */
    XCTAssertTrue(element.exists);
    /*! The accessibility identifier. */
    NSLog(@"Element indentifier:%@",element.identifier);
    /*! The frame of the element in the screen coordinate space. */
    NSLog(@"Element frame:%@",NSStringFromCGRect(element.frame));
    /*! The raw value attribute of the element. Depending on the element, the actual type can vary. */
    NSLog(@"Element value:%@",element.value);
    /*! The title attribute of the element. */
    NSLog(@"Element title:%@",element.title);
    /*! The label attribute of the element. */
    NSLog(@"Element label:%@",element.label);
    /*! The type of the element. /seealso XCUIElementType. */
    NSLog(@"Element elementType:%ld",element.elementType);
    /*! Whether or not the element is enabled for user interaction. */
    NSLog(@"Element enabled:%@",(element.enabled ? @"YES" : @"NO"));
    /*! The horizontal size class of the element. */
    NSLog(@"Element horizontalSizeClass:%ld",element.horizontalSizeClass);
    /*! The vertical size class of the element. */
    NSLog(@"Element verticalSizeClass:%ld",element.verticalSizeClass);
    /*! The value that is displayed when the element has no value. */
    NSLog(@"Element placeholderValue:%@",element.placeholderValue);
    /*! Whether or not the element is selected. */
    NSLog(@"Element selected:%@",(element.selected ? @"YES" : @"NO"));
}

@end
