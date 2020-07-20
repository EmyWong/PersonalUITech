//
//  Hook.h
//  ResponderChainDemo
//
//  Created by Emy on 2020/7/16.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hook : NSObject

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;

@end

NS_ASSUME_NONNULL_END
