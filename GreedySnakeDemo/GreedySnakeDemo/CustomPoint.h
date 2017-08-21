//
//  CustomPoint.h
//  GreedySnakeDemo
//
//  Created by zhenghaoMAC on 2017/8/18.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomPoint : NSObject
@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;


- (id)initWithX:(NSInteger)x y:(NSInteger)y;
- (BOOL)isEqual:(CustomPoint *)other;

@end
