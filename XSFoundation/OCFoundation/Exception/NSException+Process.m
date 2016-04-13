//
//  NSException+Process.m
//  XSFoundation
//
//  Created by 张松松 on 16/4/13.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "NSException+Process.h"

@implementation NSException (Process)

#pragma mark -
#pragma mark Exception UI
/**
 *  捕捉到异常之后弹出提示框
 */
- (void)showExceptionAlert
{
    NSArray *arr = [self callStackSymbols];
    NSString *title = [NSString stringWithFormat:@"%@:%@",self.name,self.reason];
    NSString *info = [arr componentsJoinedByString:@"\n"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:info
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)showExceptionWithEmail
{
    NSArray *mailtos = [NSArray arrayWithObjects:@"song_88@163.com", nil];
    NSString *appName = @"MyAPPName";
    NSString *appVersion = @"MyAppVersion";
    NSString *build = @"MyAppBuild";
    NSString *urlStr = [NSString stringWithFormat:@"mailto:%@\
                        ?subject=%@\
                        &body=Thanks for your coorperation!<br><br><br>"
                        "AppName:%@<br>""Version:%@<br>""Build:%@<br>"
                        "Details:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        [mailtos componentsJoinedByString:@","],
                        [appName stringByAppendingString:@" Bug Report"],
                        appName,appVersion,build,
                        self.name,self.reason,[[self callStackSymbols] componentsJoinedByString:@"<br>"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

/**
 *  Document/crash/{vserion}/{exceptionName}_{timestamp}
 */
- (void)writeExceptionToFile
{
    NSString *appVersion = @"MyAppVersion";
    NSString *build = @"MyAppBuild";
    NSString *detail = [NSString stringWithFormat:@"Details:\n\
                        %@\n\
                        %@\n\
                        \n\
                        %@",self.name,self.reason,[[self callStackSymbols] componentsJoinedByString:@"\n"]];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          appVersion, @"AppVersion",
                          build, @"AppBuild",
                          detail, @"excptionDetail",
                          nil];
    
    [dict writeToFile:[self exceptionFilePath] atomically:YES];
}

- (NSString *)exceptionFilePath
{
    NSString *appVersion = @"MyAppVersion";
    NSString *exceptionFileName = [NSString stringWithFormat:@"%@_%@",self.name,[NSDate date]];
    NSString *exceptionFilePath = nil;
    
    NSString *documentPath = [FileUtil documentPath];
    NSString *crashPath = [documentPath stringByAppendingPathComponent:@"crash"];
    if ([FileUtil createDirectory:crashPath])
    {
        NSString *versionPath = [crashPath stringByAppendingPathComponent:appVersion];
        if ([FileUtil createDirectory:versionPath])
        {
            exceptionFilePath = [versionPath stringByAppendingPathComponent:exceptionFileName];
        }
        else
        {
            exceptionFilePath = [crashPath stringByAppendingPathComponent:exceptionFileName];
        }
    }
    else
    {
        exceptionFilePath = [documentPath stringByAppendingPathComponent:exceptionFileName];
    }
    return exceptionFilePath;
}


@end
