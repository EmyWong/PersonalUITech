//
//  UIButton+EventInterval.m
//  ResponderChainDemo
//
//  Created by Emy on 2020/7/20.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "UIButton+EventInterval.h"

#import <objc/runtime.h>

static char * const eventIntervalKey = "eventIntervalKey";
static char * const eventUnavailableKey = "eventUnavailableKey";

@interface UIButton ()

@property (nonatomic, assign) BOOL eventUnavailable;

@end

@implementation UIButton (EventInterval)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldButtonMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method newButtonMethod = class_getInstanceMethod(self, @selector(hook_sendAction:to:forEvent:));
        if (class_addMethod(self, @selector(sendAction:to:forEvent:), method_getImplementation(newButtonMethod), method_getTypeEncoding(newButtonMethod))) {
            class_replaceMethod(self, @selector(hook_sendAction:to:forEvent:), method_getImplementation(oldButtonMethod), method_getTypeEncoding(oldButtonMethod));
        } else {
            //将sendAction:to:forEvent:方法的实现换成hook_sendAction:to:forEvent:的实现
            method_exchangeImplementations(oldButtonMethod, newButtonMethod);
        }
    });
}

- (void)hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    //如果是UIButton类
    if([self isMemberOfClass:[UIButton class]]) {
         if (self.eventUnavailable == NO) {
               self.eventUnavailable = YES;
               [self hook_sendAction:action to:target forEvent:event];
               [self performSelector:@selector(setEventUnavailable:) withObject:0           afterDelay:self.eventInterval];
         }
    } else {
         [self hook_sendAction:action to:target forEvent:event];
     }
}

#pragma mark - Setter & Getter functions

- (NSTimeInterval)eventInterval {
    return [objc_getAssociatedObject(self, eventIntervalKey) doubleValue];
}

- (void)setEventInterval:(NSTimeInterval)eventInterval {
    objc_setAssociatedObject(self, eventIntervalKey, @(eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eventUnavailable {
    
    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
}

- (void)setEventUnavailable:(BOOL)eventUnavailable {
    
    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
