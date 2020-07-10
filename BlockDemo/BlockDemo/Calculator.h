//
//  Calculator.h
//  BlockDemo
//
//  Created by Emy on 2020/7/8.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Calculator : NSObject

@property (nonatomic, assign, readonly) NSInteger result;
- (instancetype)initWithValue:(NSInteger)value;
- (Calculator *(^)(NSInteger))add;
- (Calculator *(^)(NSInteger))sub;
- (Calculator *(^)(NSInteger))multiply;
- (Calculator *(^)(NSInteger))divide;

@end

NS_ASSUME_NONNULL_END
