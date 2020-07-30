//
//  TestClass+AssociatedObject.m
//  RuntimeEGDemo
//
//  Created by Emy on 2020/7/30.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "TestClass+AssociatedObject.h"
#import "RuntimeKit.h"

@implementation TestClass (AssociatedObject)

#pragma mark - 动态属性关联
static char kDynamicAddProperty;

/**
 getter方法
 
 @return NSString 关联属性的值
 */
- (NSString *)dynamicAddProperty {
    return objc_getAssociatedObject(self, &kDynamicAddProperty);
}

/**
 setter方法
 
 @param dynamicAddProperty 动态添加属性
 */

- (void)setDynamicAddProperty:(NSString *)dynamicAddProperty {
    objc_setAssociatedObject(self, &kDynamicAddProperty, dynamicAddProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
