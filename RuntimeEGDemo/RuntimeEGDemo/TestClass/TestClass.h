//
//  TestClass.h
//  RuntimeEGDemo
//
//  Created by Emy on 2020/7/30.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *publicProperty1;
@property (nonatomic, strong) NSString *publicProperty2;

+ (void)classMethod:(NSString *)value;
- (void)publicTestMethod1:(NSString *)value1 Second:(NSString *)value2;
- (void)publicTestMethod2;

- (void)method1;

@end

NS_ASSUME_NONNULL_END
