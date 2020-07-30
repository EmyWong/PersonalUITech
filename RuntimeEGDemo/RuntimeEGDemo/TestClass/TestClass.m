//
//  TestClass.m
//  RuntimeEGDemo
//
//  Created by Emy on 2020/7/30.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "TestClass.h"
#import "RuntimeKit.h"

@interface SecondClass : NSObject
- (void)noThisMethod:(NSString *)value;
@end

@implementation SecondClass
- (void)noThisMethod:(NSString *)value {
    NSLog(@"SecondClass中的方法实现%@", value);
}
@end

@interface TestClass() {
    NSInteger _var1;
    int _var2;
    BOOL _var3;
    double _var4;
    float _var5;
}

@property (nonatomic, strong) NSMutableArray *privateProperty1;
@property (nonatomic, strong) NSNumber *privateProperty2;
@property (nonatomic, strong) NSDictionary *privateProperty3;

@end

@implementation TestClass

+ (void)classMethod: (NSString *)value {
    NSLog(@"publicTestMethod1");
}

- (void)publicTestMethod1: (NSString *)value1 Second: (NSString *)value2 {
    NSLog(@"publicTestMethod1");
}

- (void)publicTestMethod2 {
    NSLog(@"publicTestMethod2");
}

- (void)privateTestMethod1 {
    NSLog(@"privateTestMethod1");
}

- (void)privateTestMethod2 {
    NSLog(@"privateTestMethod2");
}

#pragma mark - 方法交换时使用
- (void)method1 {
    NSLog(@"我是Method1的实现");
}

//运行时方法拦截
- (void)dynamicAddMethod:(NSString *)value {
    NSLog(@"OC替换的方法：%@",value);
}

#pragma mark - 消息处理
/**
 没有找到SEL的IMP执行以下方法
 
 @param sel 当前对象调用并且找不到IMP的SEL
 @return BOOL 找到其他的执行方法时，返回YES
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return NO; //默认返回NO，当返回NO的时候，解开注释，会接着执行👇forwardingTargetForSelector:方法
    [RuntimeKit addMethod:[self class] method:sel method:@selector(dynamicAddMethod:)];
    return YES;
}

#pragma mark - 消息转发
/**
 当当前对象不存在的SEL传给其它存在该SEL的对象
 
 @param aSelector 当前对象不存在的SEL
 @return id 其它存在该SEL的对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return self; //解开注释走下面👇俩方法
    return [SecondClass new]; //让SecondClass执行
}

#pragma mark - 消息常规转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SecondClass *forwardClass = [SecondClass new];
    SEL sel = anInvocation.selector;
    if ([forwardClass respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:forwardClass];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
}

@end
