//
//  AppDelegate.m
//  TouchIDDemo
//
//  Created by 王颜华 on 16/8/10.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

//验证是否支持TouchID
- (void)judgeCanTouchId
{
    LAContext *context = [LAContext new];
    
    NSError *error;
    context.localizedFallbackTitle = @"输入密码";
    
    if ([context canEvaluatePolicy:(LAPolicyDeviceOwnerAuthenticationWithBiometrics) error:&error])
    {
        NSLog(@"支持使用");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"通过验证指纹解锁",nil) reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功");
            }
            else
            {
                /*
                 // 用户未提供有效证书,(3次机会失败 --身份验证失败)。
                 LAErrorAuthenticationFailed = kLAErrorAuthenticationFailed,
                 
                 // 认证被取消,(用户点击取消按钮)。
                 LAErrorUserCancel           = kLAErrorUserCancel,
                 
                 // 认证被取消,用户点击回退按钮(输入密码)。
                 LAErrorUserFallback         = kLAErrorUserFallback,
                 
                 // 身份验证被系统取消,(比如另一个应用程序去前台,切换到其他 APP)。
                 LAErrorSystemCancel         = kLAErrorSystemCancel,
                 
                 // 身份验证无法启动,因为密码在设备上没有设置。
                 LAErrorPasscodeNotSet       = kLAErrorPasscodeNotSet,
                 
                 // 身份验证无法启动,因为触摸ID在设备上不可用。
                 LAErrorTouchIDNotAvailable  = kLAErrorTouchIDNotAvailable,
                 
                 // 身份验证无法启动,因为没有登记的手指触摸ID。 没有设置指纹密码时。
                 LAErrorTouchIDNotEnrolled   = kLAErrorTouchIDNotEnrolled,
                 **/

                if (error.code == kLAErrorUserFallback) {
                    NSLog(@"用户选择了另一种方式");
                }
                else if (error.code == kLAErrorUserCancel)
                {
                    NSLog(@"用户取消");
                }
                else if (error.code == kLAErrorSystemCancel)
                {
                    NSLog(@"切换前台被取消");
                }
                else if (error.code == kLAErrorPasscodeNotSet)
                {
                    NSLog(@"身份验证没有设置");
                }
                else
                {
                    NSLog(@"验证失败");
                }
            }
        }];
    }
    else
    {
        NSLog(@"不支持使用");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self judgeCanTouchId];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
