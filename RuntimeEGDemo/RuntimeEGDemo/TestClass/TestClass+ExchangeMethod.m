//
//  TestClass+ExchangeMethod.m
//  RuntimeEGDemo
//
//  Created by Emy on 2020/7/30.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "TestClass+ExchangeMethod.h"
#import "RuntimeKit.h"

@implementation TestClass (ExchangeMethod)

- (void)exchangeMethod {
    [RuntimeKit exchangeMethod:[self class] method:@selector(method1) method:@selector(method2)];
}

- (void)method2 {
    [self method2];
    NSLog(@"可以在Method1基础上添加任何东西了");
}

@end
