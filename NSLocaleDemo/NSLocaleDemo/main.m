//
//  main.m
//  NSLocaleDemo
//
//  Created by zhenghaoMAC on 2017/8/21.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //返回系统所支持的全部国家和语言的集合
        NSArray *locales = [NSLocale availableLocaleIdentifiers];
        //遍历数组的每个元素，一次获取所支持的所有NSLocale
        for (int i = 0; i < locales.count; i++) {
            NSString *localeId = [locales objectAtIndex:i];
            NSLog(@"%@",localeId);
        }
        //获取当前的Locale
        NSLocale *curLocale = [NSLocale currentLocale];
        NSLog(@"当前Locale:%@",curLocale.localeIdentifier);
        
        //在默认值中找到AppleLanguages,返回值是一个NSArray的集合
        NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defs objectForKey:@"AppleLanguages"];
        NSLog(@"所有语言包括：%@",languages);
        NSLog(@"首选语言：%@",[languages objectAtIndex:0]);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
