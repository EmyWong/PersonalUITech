//
//  Calculator.m
//  BlockDemo
//
//  Created by Emy on 2020/7/8.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "Calculator.h"

@interface Calculator ()
@property (nonatomic, assign, readwrite) NSInteger result;
@end

@implementation Calculator

- (instancetype)initWithValue:(NSInteger)value {
    if (self = [super init]) {
        self.result = value;
    }
    return self;
}

- (Calculator * _Nonnull (^)(NSInteger))add {
    return ^(NSInteger value) {
        self.result += value;
        return self;
    };
}
- (Calculator * _Nonnull (^)(NSInteger))sub {
    return ^(NSInteger value) {
        self.result -= value;
        return self;
    };
}
- (Calculator * _Nonnull (^)(NSInteger))multiply {
    return ^(NSInteger value) {
        self.result *= value;
        return self;
    };
}
- (Calculator * _Nonnull (^)(NSInteger))divide {
    return ^(NSInteger value){
        self.result /= value;
        return self;
    };
}

@end
