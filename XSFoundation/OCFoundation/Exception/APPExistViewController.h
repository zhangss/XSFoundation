//
//  APPExistViewController.h
//  XSFoundation
//
//  Created by 张松松 on 16/4/12.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

/**
 *  退出APP
 *
 *  官方回复：https://developer.apple.com/library/ios/qa/qa1561/_index.html
 */
/**
 *  在iOS5之前，程序是可以自带退出按钮供用户退出，该按钮调用
 [[UIApplication sharedApplication] performSelector:@selector(terminateWithSuccess)]
 实现退出，内核会自动判断程序退出后的状态，第一种情况，如果plist上没有勾选"Application does not run in background"，那么该程序退出后会继续在后台运行，次状态有别于Windows下，在iOS中该状态应该用“等待激活”来描述，一些像QQ这些即时通讯程序在退出后立即断网，其余交由系统的通知系统来处理，无需联网的程序再重新激活后，基本上是恢复到退出前的状态，这点和安卓没有什么区别。第二种情况，如果未勾选run in background，那么会彻底退出，该进程所占用的内存空间(heap, stack, and static等等)和此进程占用的文件句柄全部会被内核处理干净。
 
 在iOS5.01之后，苹果认为退出按钮的功能要和Home键合并，也就是说按下Home键之后内核会自动对Process进行处理。解释是：“Regardless of how a process terminates, the same code in the kernel is eventually executed. This kernel code closes all the open descriptors for the process, releases the memory that it was using, and the like.”
 如果是程序在调用exit系统调用退出的话整个process都交付给内核处理了，由内核来一并清理掉，所以这个时候就没需要单独来对每个对象来dealloc了。
 
 *
 */

#import "BaseViewController.h"

@interface APPExistViewController : BaseViewController

@property (nonatomic, strong) IBOutlet UIButton *exitButton;
@property (nonatomic, strong) IBOutlet UIButton *abortButton;
@property (nonatomic, strong) IBOutlet UIButton *performSelectorButton;
@property (nonatomic, strong) IBOutlet UIButton *assertButton;
@property (nonatomic, strong) IBOutlet UIButton *nsassertButton;
@property (nonatomic, strong) IBOutlet UIButton *exceptionButton;
@property (nonatomic, strong) IBOutlet UIButton *openUrlButton;

- (IBAction)buttonClicked:(id)sender;

@end
