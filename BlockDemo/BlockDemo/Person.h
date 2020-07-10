//
//  Person.h
//  BlockDemo
//
//  Created by Emy on 2020/7/8.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, copy) NSString *strCopy;
@property (nonatomic, strong) NSString *strStrong;
@end

NS_ASSUME_NONNULL_END
