//
//  ViewReusePool.m
//  CustomLetterIndexView
//
//  Created by Emy on 2018/8/14.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "ViewReusePool.h"

@interface ViewReusePool ()
//等待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;
//使用中的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation ViewReusePool

- (instancetype)init {
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView *)dequeueReusableView {
    UIView *view = [_waitUsedQueue anyObject];
    
    if (view == nil) {
        return nil;
    } else {
        //进行队列移动
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

- (void)addUsingView:(UIView *)view {
    if (view == nil) {
        return;
    }
    
    //添加视图到使用中的队列
    [_usingQueue addObject:view];
}

- (void)reset {
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        //从使用中队列移除
        [_usingQueue removeObject:view];
        //加入等待使用的队列
        [_waitUsedQueue addObject:view];
    }
}
@end
