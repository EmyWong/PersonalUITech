//
//  NSMutableArray+Extension.m
//  ExceptionDemo
//
//  Created by Emy on 2018/8/18.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)

+ (void)load {
    Class arrayMClass = NSClassFromString(@"__NSArrayM");
    
    //获取系统的添加元素的方法
    Method addObject = class_getInstanceMethod(arrayMClass, @selector(addObject:));
    
    //获取我们自定义添加元素的方法
    Method avoidCrashAddObject = class_getInstanceMethod(arrayMClass, @selector(avoidCrashAddObject:));
    
    //将两个方法进行交换
    //当你调用addObject的时候，其实就是调用avoidCrashAddObject
    //当你调用avoidCrashAddObject的时候，其实就是调用addObject
    method_exchangeImplementations(addObject, avoidCrashAddObject);
}

- (void)avoidCrashAddObject:(id)object {

    @try {
        
        //可能出现异常的方法 比如数组不能添加空对象 所以addObject可能会出现异常
        [self avoidCrashAddObject:object];//本质是调用addObject
    
    } @catch (NSException *exception) {
    
        //捕捉到异常后对该异常进行处理
        NSLog(@"\n异常名称：%@\n异常原因：%@",exception.name,exception.reason);
    
    } @finally {
    
        //这里的代码一定会执行，可以进行相应的操作
    
    }
}

@end
