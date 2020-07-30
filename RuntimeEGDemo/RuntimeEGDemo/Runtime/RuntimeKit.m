//
//  RuntimeKit.m
//  RuntimeEGDemo
//
//  Created by Emy on 2020/7/30.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "RuntimeKit.h"

@implementation RuntimeKit
/**
 获取类名
 
 @param class 响应类
 @return NSString 类名
 */
+ (NSString *)fetchClassName:(Class)class {
    const char *className = class_getName(class);
    return [NSString stringWithUTF8String:className];
}

/**
 获取成员变量
 
 @param class 响应类
 @return NSArray 成员变量列表
 */
+ (NSArray *)fetchIvarList:(Class)class {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    
    NSMutableArray *mutableList = [[NSMutableArray alloc] initWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String:ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        [mutableList addObject:dic];
    }

    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的属性列表，包括私有和公有属性，以及定义在延展（extention)中的属性
 
 @param class 响应类
 @return NSArray 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)class {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    
    NSMutableArray *mutableList = [[NSMutableArray alloc] initWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的实例方法列表：getter，setter，对象方法等，但不能获取类方法
 
 @param class 响应类
 @return NSArray 实例方法列表
 */
+ (NSArray *)fetchInstanceMethodList:(Class)class {
    unsigned int count = 0;
    Method *instanceMethodList = class_copyMethodList(class, &count);
    
    NSMutableArray *mutableList = [[NSMutableArray alloc] initWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Method method = instanceMethodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    
    free(instanceMethodList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取协议列表
 
 @param class 响应类
 @return NSArray 协议列表
 */

+ (NSArray *)fetchProtocolList:(Class)class {
    unsigned int count  = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableArray addObject:[NSString stringWithUTF8String:protocolName]];
    }
    free(protocolList);
    return [NSArray arrayWithArray:mutableArray];
}

/**
 往类上添加新的方法与实现
 
 @param class 响应类
 @param methodSel 方法名
 @param methodSelImpl 对应方法实现的方法名
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl {
    Method method = class_getInstanceMethod(class, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}

/**
 方法交换
 
 @param class 响应类
 @param oldMethod 被交换方法
 @param newMethod 交换方法
 */
+ (void)exchangeMethod:(Class)class method:(SEL)oldMethod method:(SEL)newMethod {
    Method method1 = class_getInstanceMethod(class, oldMethod);
    Method method2 = class_getInstanceMethod(class, newMethod);
    method_exchangeImplementations(method1, method2);
}

@end
