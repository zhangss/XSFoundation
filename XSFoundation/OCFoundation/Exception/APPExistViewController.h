//
//  APPExistViewController.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/12.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

/**
 *  退出APP
 *  1.无论怎么样，APP退出之后，双击Home键都能看到使用APP的记录。
      只是退出之后，在通过双击Home启动APP时，APP是重新加载的。
 *  2.无论哪种退出，APP显示效果均为黑屏闪退。
 *  3.推荐使用abort(),出了exit之外，其他退出方式最后均是通过abort退出。
 *  4.所有崩溃都不会调用appDelegate回调。
 *  5.异常类崩溃可以统一用Handler捕获。无法阻止崩溃，但是可以在崩溃之前处理日志信息或者给出提示：
      5.1记录日志到本地，以便查看。
      5.2调用邮件UI，发送崩溃信息邮件。
      5.3同步传递信息到服务端。
 *  6.部分异常可以通过try/cacth捕获，捕获之后被吞掉不会继续传递，可以阻止APP崩溃。但是添加try/catch不现实。
 *  7.善用断言调试程序（参数断言与方法断言）。
 *
 *  官方回复：https://developer.apple.com/library/ios/qa/qa1561/_index.html
 */


/**
 如果plist上没有勾选"Application does not run in background"，那么该程序退出后会继续在后台运行，次状态有别于Windows下，在iOS中该状态应该用“等待激活”来描述，一些像QQ这些即时通讯程序在退出后立即断网，其余交由系统的通知系统来处理，无需联网的程序再重新激活后，基本上是恢复到退出前的状态，这点和安卓没有什么区别。
 第二种情况，如果未勾选run in background，那么会彻底退出，该进程所占用的内存空间(heap, stack, and static等等)和此进程占用的文件句柄全部会被内核处理干净。
 */

/**
 *  1.xcode-window-devices-真机-device log可以查看本机崩溃日志信息。日志自解析。
 *  2.itunesConnect可以查看到崩溃情况图表，
      没有详细信息，而且仅限于参与了与APP开发成员共享诊断和使用情况数据的用户。比例不大。
 */

#import "BaseViewController.h"

@interface APPExistViewController : BaseTableViewController

@end
