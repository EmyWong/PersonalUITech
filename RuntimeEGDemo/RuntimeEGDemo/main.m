//
//  main.m
//  RuntimeEGDemo
//
//  Created by Emy on 2020/7/30.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestClass.h"
#import "RuntimeKit.h"
#import "TestClass+ExchangeMethod.h"
#import "TestClass+AssociatedObject.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *className = [RuntimeKit fetchClassName:[TestClass class]];
        
        NSArray *ivarList = [RuntimeKit fetchIvarList:[TestClass class]];
        NSLog(@"获取%@的成员变量列表：%@",className, ivarList);
        
        NSArray *propertyList = [RuntimeKit fetchPropertyList:[TestClass class]];
        NSLog(@"获取%@的属性列表：%@",className, propertyList);

        NSArray *instanceMethodList = [RuntimeKit fetchInstanceMethodList:[TestClass class]];
        NSLog(@"获取%@的实例方法列表：%@",className, instanceMethodList);
        
        NSArray *protocolList = [RuntimeKit fetchProtocolList:[TestClass class]];
        NSLog(@"获取%@的协议列表：%@",className, protocolList);
        
        TestClass *test = [[TestClass alloc] init];
        
        [test performSelector:@selector(noThisMethod:) withObject:@"实例方法参数"];
        
        test.dynamicAddProperty = @"我是动态添加的属性";
        NSLog(@"%@", test.dynamicAddProperty);

        [test exchangeMethod];
        [test method1];
    }
    return 0;
}
