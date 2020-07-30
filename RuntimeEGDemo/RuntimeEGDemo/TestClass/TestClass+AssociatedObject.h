//
//  TestClass+AssociatedObject.h
//  RuntimeEGDemo
//
//  Created by Emy on 2020/7/30.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "TestClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestClass (AssociatedObject)

@property (nonatomic, strong) NSString *dynamicAddProperty;

@end

NS_ASSUME_NONNULL_END
