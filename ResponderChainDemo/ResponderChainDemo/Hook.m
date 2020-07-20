//
//  Hook.m
//  ResponderChainDemo
//
//  Created by Emy on 2020/7/16.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "Hook.h"
#import <objc/runtime.h>

@implementation Hook

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Class class = classObject;
    //得到被替换类的实例方法
    Method fromMethod = class_getInstanceMethod(class, fromSelector);
    //得到替换类的实例方法
    Method toMethod = class_getInstanceMethod(class, toSelector);
    
    //class_addMethod 返回成功表示被替换的方法没实现，然后会通过 class_addMethod 方法先实现
    if (class_addMethod(class, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        //进行方法的替换
        class_replaceMethod(class, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    } else {
        //交换IMP指针
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

@end
