//
//  RuntimeKit.h
//  RuntimeEGDemo
//
//  Created by Emy on 2020/7/30.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeKit : NSObject

/**
 获取类名
 
 @param class 响应类
 @return NSString 类名
 */
+ (NSString *)fetchClassName:(Class)class;

/**
 获取成员变量
 
 @param class 响应类
 @return NSArray 成员变量列表
 */
+ (NSArray *)fetchIvarList:(Class)class;

/**
 获取类的属性列表，包括私有和公有属性，以及定义在延展（extention)中的属性
 
 @param class 响应类
 @return NSArray 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)class;

/**
 获取类的实例方法列表：getter，setter，对象方法等，但不能获取类方法
 
 @param class 响应类
 @return NSArray 实例方法列表
 */
+ (NSArray *)fetchInstanceMethodList:(Class)class;

/**
 获取协议列表
 
 @param class 响应类
 @return NSArray 协议列表
 */

+ (NSArray *)fetchProtocolList:(Class)class;

/**
 往类上添加新的方法与实现
 
 @param class 响应类
 @param methodSel 方法名
 @param methodSelImpl 对应方法实现的方法名
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl;

/**
 方法交换
 
 @param class 响应类
 @param oldMethod 被交换方法
 @param newMethod 交换方法
 */
+ (void)exchangeMethod:(Class)class method:(SEL)oldMethod method:(SEL)newMethod;
@end

NS_ASSUME_NONNULL_END
