//
//  AppDelegate.m
//  Demo
//
//  Created by 王颜华 on 16/7/14.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#define jPushAppKey @"974d648cea494d7500ed7aa5"
@interface AppDelegate ()
@property NSData * deviceToken;
@property NSString * noticeType;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    static NSString *jPushChannel = @"Publish channel";
    static BOOL isProduction = TRUE;
    //初始化
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    [JPUSHService setupWithOption:launchOptions appKey:jPushAppKey channel:jPushChannel apsForProduction:isProduction];
    
    NSString * userInfoJson =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoJson"];
    //    if (userInfoJson){
    NSLog(@"userInfoJson from out : %@", userInfoJson);
    //    }
    //
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfoJson"];
    if (launchOptions){
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        if (remoteNotification) {
            // remoteNotification 就是userInfo
            
            [self networkDidReceiveMessage: remoteNotification];
        }
    }
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService resetBadge];
   

    return YES;
}
- (void)networkDidReceiveMessage: (NSDictionary *) userInfo{
    
    // 这里判断一下userInfo里的消息，以决定使用哪种类型的页面。
    NSError *error;
    
    NSData *userInfoJsonData = [NSJSONSerialization dataWithJSONObject:userInfo options:NSJSONWritingPrettyPrinted error:&error];
    if (error){
        NSLog(@"error : %@" , [error localizedDescription]);
        return;
    }
    if (!userInfoJsonData){
        
        NSLog(@"error : %@" , [error localizedDescription]);
        return;
    }
    NSString *jsonString = [[NSString alloc] initWithData:userInfoJsonData encoding:NSUTF8StringEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:jsonString forKey:@"userInfoJson"];
    
}


// =============================JPush 监听方法======================================================================
/*
 // 建议开发者加上API里面提供下面 5 种类型的通知：
 extern NSString * const kJPFNetworkDidSetupNotification; // 建立连接
 
 extern NSString * const kJPFNetworkDidCloseNotification; // 关闭连接
 
 extern NSString * const kJPFNetworkDidRegisterNotification; // 注册成功
 
 extern NSString * const kJPFNetworkDidLoginNotification; // 登录成功
 */


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"=======");
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
    _deviceToken = deviceToken;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings: (UIUserNotificationSettings *)notificationSettings {
    NSLog(@"bbb");
    [application registerForRemoteNotifications];
}
// 获取服务端的通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *) userInfo {
    
    
    NSLog(@"*********");
    
    //[application setApplicationIconBadgeNumber:0];
    //[application cancelAllLocalNotifications];
    //[JPUSHService resetBadge];
    
    NSNotification *notification = [[NSNotification alloc] initWithName:kJPFNetworkDidReceiveMessageNotification object:nil userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler: (void (^)(UIBackgroundFetchResult)) completionHandler {
    
    [JPUSHService handleRemoteNotification: userInfo];
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"openWeb" object:nil];
    
    NSLog(@"通知信息%@",userInfo);
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService resetBadge];
    
    NSNotification *notification = [[NSNotification alloc] initWithName:kJPFNetworkDidReceiveMessageNotification object:nil userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    NSLog(@"………………………………");
    self.noticeType = (NSString *)[userInfo objectForKey:@"noticeType"];
        if (self.noticeType == nil) {
            
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *) notification completionHandler:(void (^)())completionHandler {
    NSLog(@"ccccc");
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *) identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    NSLog(@"aaaaa");
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
