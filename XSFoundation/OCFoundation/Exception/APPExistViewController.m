//
//  APPExistViewController.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/12.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "APPExistViewController.h"

@interface APPExistViewController ()

@end

@implementation APPExistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)buttonClicked:(id)sender
{
    if (sender == self.exitButton) {
        /**
         *  正常退出，调用exit会让用户感觉程序崩溃了。
         *  另外，使用exit可能会丢失数据，因为调用exit并不会调用-applicationWillTerminate:方法和UIApplicationDelegate方法；
         *  存在被拒风险
         */
        /**
         *  测试结果
         *  1.无断点停留，直接黑屏崩溃
         *  2.控制台无日志输出
         */
        exit(0);
    }else if (sender == self.abortButton) {
        /**
         *  异常退出程序
         *  实际测试不会：abort就像是点击了home键，有过渡动画，一般我们在使用的时候会选择abort();
         */
        /**
         *  测试结果
         *  1.断点停留在调用行
         *  2.显示Thred 1: signal SIGABRT
         *  2.1而后显示Thred 1: EXC_BAD_INSTRUCTION,真机为EXIT_BREAKPOINT
         *  3.控制台无输出
         */
        abort();
    }else if (sender == self.performSelectorButton) {
        /**
         *  存在被拒风险
         */
        /**
         *  测试结果
         *  1.断点停留在 main函数
         *  2.显示Thred 1: signal SIGABRT
         *  2.1而后显示Thred 1: EXC_BAD_INSTRUCTION,真机为EXIT_BREAKPOINT
         *  3.控制台输出崩溃信息，捕获异常NSInvalidArgumentException，看堆栈信息最后是通过abort()崩溃的
         */
        /**
         2016-04-12 17:54:16.164 XSFoundation[5119:289173] -[APPExistViewController nonExistentMethodWillTerminateTheApp]: unrecognized selector sent to instance 0x7fc30a8043e0
         2016-04-12 17:54:16.169 XSFoundation[5119:289173] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[APPExistViewController nonExistentMethodWillTerminateTheApp]: unrecognized selector sent to instance 0x7fc30a8043e0'
         *** First throw call stack:
         (
         0   CoreFoundation                      0x0000000102eefd85 __exceptionPreprocess + 165
         1   libobjc.A.dylib                     0x0000000102963deb objc_exception_throw + 48
         2   CoreFoundation                      0x0000000102ef8d3d -[NSObject(NSObject) doesNotRecognizeSelector:] + 205
         3   CoreFoundation                      0x0000000102e3ecfa ___forwarding___ + 970
         4   CoreFoundation                      0x0000000102e3e8a8 _CF_forwarding_prep_0 + 120
         5   XSFoundation                        0x0000000102414b6c -[APPExistViewController buttonClicked:] + 284
         6   UIKit                               0x0000000103ee0a8d -[UIApplication sendAction:to:from:forEvent:] + 92
         7   UIKit                               0x0000000104053e67 -[UIControl sendAction:to:forEvent:] + 67
         8   UIKit                               0x0000000104054143 -[UIControl _sendActionsForEvents:withEvent:] + 327
         9   UIKit                               0x0000000104053263 -[UIControl touchesEnded:withEvent:] + 601
         10  UIKit                               0x0000000103f5399f -[UIWindow _sendTouchesForEvent:] + 835
         11  UIKit                               0x0000000103f546d4 -[UIWindow sendEvent:] + 865
         12  UIKit                               0x0000000103effdc6 -[UIApplication sendEvent:] + 263
         13  UIKit                               0x0000000103ed9553 _UIApplicationHandleEventQueue + 6660
         14  CoreFoundation                      0x0000000102e15301 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
         15  CoreFoundation                      0x0000000102e0b22c __CFRunLoopDoSources0 + 556
         16  CoreFoundation                      0x0000000102e0a6e3 __CFRunLoopRun + 867
         17  CoreFoundation                      0x0000000102e0a0f8 CFRunLoopRunSpecific + 488
         18  GraphicsServices                    0x00000001096a4ad2 GSEventRunModal + 161
         19  UIKit                               0x0000000103edef09 UIApplicationMain + 171
         20  XSFoundation                        0x000000010241d83f main + 111
         21  libdyld.dylib                       0x000000010630292d start + 1
         22  ???                                 0x0000000000000001 0x0 + 1
         )
         libc++abi.dylib: terminating with uncaught exception of type NSException
         */
        /**
         2016-04-12 18:19:14.269 XSFoundation[3023:810568] -[APPExistViewController nonExistentMethodWillTerminateTheApp]: unrecognized selector sent to instance 0x13fd28300
         2016-04-12 18:19:14.273 XSFoundation[3023:810568] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[APPExistViewController nonExistentMethodWillTerminateTheApp]: unrecognized selector sent to instance 0x13fd28300'
         *** First throw call stack:
         (0x1819f9900 0x181067f80 0x181a0061c 0x1819fd5b8 0x18190168c 0x1000a7238 0x186723e50 0x186723dcc 0x18670ba88 0x1867236e4 0x186723314 0x18671be30 0x1866ec4cc 0x1866ea794 0x1819b0efc 0x1819b0990 0x1819ae690 0x1818dd680 0x182dec088 0x186754d90 0x1000af50c 0x18147e8b8)
         libc++abi.dylib: terminating with uncaught exception of type NSException
         */
        [self performSelector:@selector(nonExistentMethodWillTerminateTheApp)];
    }else if (sender == self.assertButton) {
        //只有Debug模式有效，Release无效
        /**
         *  在Debug模式下，每次运行到这里后会计算括号中的表达式，如果表达式为0，则中断执行。
         *  在Release模式下，这句语句不会被编译进代码.
         *  ASSERT一般用于程序内部确认参数的正确性，即调用内部函数的时候，要由调用者保证参数的正确，而被调用函数内部，就可以通过ASSERT来检查参数是否满足要求。
         */
        /**
         *  测试结果
         *  1.断点停留在调用行
         *  2.显示Thred 1: signal SIGABRT
         *  2.1而后显示Thred 1: EXC_BAD_INSTRUCTION  (instruction指令),真机为EXIT_BREAKPOINT
         *  3.控制台输出崩溃信息，看堆栈最后是通过abort()实现
         */
        /**
         Assertion failed: (param != nil), function -[APPExistViewController buttonClicked:], file /Users/YiSheng/Desktop/XSFoundation/XSFoundation/OCFoundation/Exception/APPExistViewController.m, line 85.
         */
        NSString *param;
        assert(param != nil);
//        assert(1);  //无效，0有效
    }else if (sender == self.nsassertButton) {
        /**
         *  assert是C里面的宏。用于断言。
         *  NSAssert只能在Objective-c里面使用。是assert的一个扩充。
         *  NSAssert能捕获assert类异常及打印一些可读的日志。而assert只是让app crash(abort).
         *  Xcode 4.2以后，在release版本中断言是默认关闭的，这是由宏NS_BLOCK_ASSERTIONS来处理的。免除了忘记关闭断言造成的程序不稳定.
         *  频繁地调用会极大的影响程序的性能，增加额外开销。
         */

        /**
         *  针对参数是否存在断言，内部调用的还是NSAssert/NSCAssert
         */
        /**
         *  测试结果
         *  1.断点停留在 main函数
         *  2.显示Thred 1: signal SIGABRT
         *  2.1而后显示Thred 1: EXC_BAD_INSTRUCTION，真机为EXIT_BREAKPOINT
         *  3.控制台输出崩溃信息，增加了一个异常信息抛出，看堆栈信息最后是通过abort()崩溃的
         */
        /**
         2016-04-12 17:38:13.522 XSFoundation[4909:277467] *** Assertion failure in -[APPExistViewController buttonClicked:], /Users/YiSheng/Desktop/XSFoundation/XSFoundation/OCFoundation/Exception/APPExistViewController.m:100
         2016-04-12 17:38:13.534 XSFoundation[4909:277467] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid parameter not satisfying: param'
         *** First throw call stack:
         (
         0   CoreFoundation                      0x0000000103cd5d85 __exceptionPreprocess + 165
         1   libobjc.A.dylib                     0x0000000103749deb objc_exception_throw + 48
         2   CoreFoundation                      0x0000000103cd5bea +[NSException raise:format:arguments:] + 106
         3   Foundation                          0x0000000103393d5a -[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:] + 198
         4   XSFoundation                        0x00000001031fad87 -[APPExistViewController buttonClicked:] + 823
         5   UIKit                               0x0000000104cc6a8d -[UIApplication sendAction:to:from:forEvent:] + 92
         6   UIKit                               0x0000000104e39e67 -[UIControl sendAction:to:forEvent:] + 67
         7   UIKit                               0x0000000104e3a143 -[UIControl _sendActionsForEvents:withEvent:] + 327
         8   UIKit                               0x0000000104e39263 -[UIControl touchesEnded:withEvent:] + 601
         9   UIKit                               0x0000000104d3999f -[UIWindow _sendTouchesForEvent:] + 835
         10  UIKit                               0x0000000104d3a6d4 -[UIWindow sendEvent:] + 865
         11  UIKit                               0x0000000104ce5dc6 -[UIApplication sendEvent:] + 263
         12  UIKit                               0x0000000104cbf553 _UIApplicationHandleEventQueue + 6660
         13  CoreFoundation                      0x0000000103bfb301 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
         14  CoreFoundation                      0x0000000103bf122c __CFRunLoopDoSources0 + 556
         15  CoreFoundation                      0x0000000103bf06e3 __CFRunLoopRun + 867
         16  CoreFoundation                      0x0000000103bf00f8 CFRunLoopRunSpecific + 488
         17  GraphicsServices                    0x000000010a48aad2 GSEventRunModal + 161
         18  UIKit                               0x0000000104cc4f09 UIApplicationMain + 171
         19  XSFoundation                        0x000000010320383f main + 111
         20  libdyld.dylib                       0x00000001070e892d start + 1
         21  ???                                 0x0000000000000001 0x0 + 1
         )
         libc++abi.dylib: terminating with uncaught exception of type NSException
         */
        /**
         *  2016-04-12 18:16:19.964 XSFoundation[3011:809244] *** Assertion failure in -[APPExistViewController buttonClicked:], /Users/YiSheng/Desktop/XSFoundation/XSFoundation/OCFoundation/Exception/APPExistViewController.m:177
         2016-04-12 18:16:19.969 XSFoundation[3011:809244] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid parameter not satisfying: param'
         *** First throw call stack:
         (0x1819f9900 0x181067f80 0x1819f97d0 0x18236c99c 0x1000bf424 0x186723e50 0x186723dcc 0x18670ba88 0x1867236e4 0x186723314 0x18671be30 0x1866ec4cc 0x1866ea794 0x1819b0efc 0x1819b0990 0x1819ae690 0x1818dd680 0x182dec088 0x186754d90 0x1000c750c 0x18147e8b8)
         libc++abi.dylib: terminating with uncaught exception of type NSException
        */
        NSString *param;
        NSParameterAssert(param);
//        NSCParameterAssert(param);
        
        /**
         *  Block中使用NSAssert要特别注意循环引用。宏定义展开后会出现对self的持有，容易导致循环引用。NSCAssert宏定义中并没有出现self，所以在block中使用NSCAssert可以避免循环引用的发生。
         */
        /**
         *  2016-04-12 17:43:51.164 XSFoundation[4995:281595] *** Assertion failure in -[APPExistViewController buttonClicked:], /Users/YiSheng/Desktop/XSFoundation/XSFoundation/OCFoundation/Exception/APPExistViewController.m:146
         2016-04-12 17:43:51.170 XSFoundation[4995:281595] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'NSAsser Terminate'
         *** First throw call stack:
         (
         0   CoreFoundation                      0x000000010ef04d85 __exceptionPreprocess + 165
         1   libobjc.A.dylib                     0x000000010e978deb objc_exception_throw + 48
         2   CoreFoundation                      0x000000010ef04bea +[NSException raise:format:arguments:] + 106
         3   Foundation                          0x000000010e5c2d5a -[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:] + 198
         4   XSFoundation                        0x000000010e429f02 -[APPExistViewController buttonClicked:] + 834
         5   UIKit                               0x000000010fef5a8d -[UIApplication sendAction:to:from:forEvent:] + 92
         6   UIKit                               0x0000000110068e67 -[UIControl sendAction:to:forEvent:] + 67
         7   UIKit                               0x0000000110069143 -[UIControl _sendActionsForEvents:withEvent:] + 327
         8   UIKit                               0x0000000110068263 -[UIControl touchesEnded:withEvent:] + 601
         9   UIKit                               0x000000010ff6899f -[UIWindow _sendTouchesForEvent:] + 835
         10  UIKit                               0x000000010ff696d4 -[UIWindow sendEvent:] + 865
         11  UIKit                               0x000000010ff14dc6 -[UIApplication sendEvent:] + 263
         12  UIKit                               0x000000010feee553 _UIApplicationHandleEventQueue + 6660
         13  CoreFoundation                      0x000000010ee2a301 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
         14  CoreFoundation                      0x000000010ee2022c __CFRunLoopDoSources0 + 556
         15  CoreFoundation                      0x000000010ee1f6e3 __CFRunLoopRun + 867
         16  CoreFoundation                      0x000000010ee1f0f8 CFRunLoopRunSpecific + 488
         17  GraphicsServices                    0x00000001156b9ad2 GSEventRunModal + 161
         18  UIKit                               0x000000010fef3f09 UIApplicationMain + 171
         19  XSFoundation                        0x000000010e43286f main + 111
         20  libdyld.dylib                       0x000000011231792d start + 1
         21  ???                                 0x0000000000000001 0x0 + 1
         )
         libc++abi.dylib: terminating with uncaught exception of type NSException
         */
        NSAssert([param isEqualToString:@"login"], @"NSAsser Terminate"); //OC方法
//        NSCAssert(YES, @"NSCAsser Terminate"); //C方法
    }else if (sender == self.exceptionButton) {
        /**
         *  TODO:ARC模式下异常容易出现泄露。Leaks检查
         */
//        @try {
//            //Code that can potentially throw an exception
//        } @catch (NSException *exception) {
//            @throw exception;
//        } @finally {
//            //Code that gets executed whether or not an exception is thrown
//        }
        /**
         *  测试结果：
         *  1.断点停留在 main函数
         *  2.显示Thred 1: signal SIGABRT
         *  2.1而后显示Thred 1: EXC_BAD_INSTRUCTION,真机为EXIT_BREAKPOINT
         *  3.控制台输出崩溃信息，看堆栈信息最后是通过abort()崩溃的
         */
        
        /**
         *  2016-04-12 17:23:32.368 XSFoundation[4639:265469] *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: 'APP Need Terminate'
         *** First throw call stack:
         (
         0   CoreFoundation                      0x000000010a059d85 __exceptionPreprocess + 165
         1   libobjc.A.dylib                     0x0000000109acddeb objc_exception_throw + 48
         2   XSFoundation                        0x000000010957efcc -[APPExistViewController buttonClicked:] + 1324
         3   UIKit                               0x000000010b04aa8d -[UIApplication sendAction:to:from:forEvent:] + 92
         4   UIKit                               0x000000010b1bde67 -[UIControl sendAction:to:forEvent:] + 67
         5   UIKit                               0x000000010b1be143 -[UIControl _sendActionsForEvents:withEvent:] + 327
         6   UIKit                               0x000000010b1bd263 -[UIControl touchesEnded:withEvent:] + 601
         7   UIKit                               0x000000010b0bd99f -[UIWindow _sendTouchesForEvent:] + 835
         8   UIKit                               0x000000010b0be6d4 -[UIWindow sendEvent:] + 865
         9   UIKit                               0x000000010b069dc6 -[UIApplication sendEvent:] + 263
         10  UIKit                               0x000000010b043553 _UIApplicationHandleEventQueue + 6660
         11  CoreFoundation                      0x0000000109f7f301 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
         12  CoreFoundation                      0x0000000109f7522c __CFRunLoopDoSources0 + 556
         13  CoreFoundation                      0x0000000109f746e3 __CFRunLoopRun + 867
         14  CoreFoundation                      0x0000000109f740f8 CFRunLoopRunSpecific + 488
         15  GraphicsServices                    0x000000011080ead2 GSEventRunModal + 161
         16  UIKit                               0x000000010b048f09 UIApplicationMain + 171
         17  XSFoundation                        0x000000010958784f main + 111
         18  libdyld.dylib                       0x000000010d46c92d start + 1
         19  ???                                 0x0000000000000001 0x0 + 1
         )
         libc++abi.dylib: terminating with uncaught exception of type NSException
         */
        /**
         *  2016-04-12 18:20:00.525 XSFoundation[3026:810872] *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: 'APP Need Terminate'
         *** First throw call stack:
         (0x1819f9900 0x181067f80 0x100073628 0x186723e50 0x186723dcc 0x18670ba88 0x1867236e4 0x186723314 0x18671be30 0x1866ec4cc 0x1866ea794 0x1819b0efc 0x1819b0990 0x1819ae690 0x1818dd680 0x182dec088 0x186754d90 0x10007b50c 0x18147e8b8)
         libc++abi.dylib: terminating with uncaught exception of type NSException
         
         */
        NSException *excption = [NSException exceptionWithName:NSUndefinedKeyException
                                                        reason:@"APP Need Terminate"
                                                      userInfo:nil];
        @throw excption;
    }else if (sender == self.openUrlButton) {
        //只是跳转，不断崩溃
        BOOL canOpen = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        NSLog(@"canOpen:%@",canOpen?@"YES":@"NO");
    }
}

@end
