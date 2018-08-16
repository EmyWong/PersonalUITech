//
//  CustomButton.m
//  CustomButton
//
//  Created by Emy on 2018/8/16.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.userInteractionEnabled || [self isHidden] || self.alpha <= 0.01) {
        return nil;
    }
    if ([self pointInside:point withEvent:event]) {
        //遍历当前对象的子视图
        __block UIView *hit = nil;
        [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //坐标转换
            CGPoint convertPoint = [self convertPoint:point toView:obj];
            //调用子视图的intest方法
            hit = [obj hitTest:convertPoint withEvent:event];
            if (hit) {
                *stop = YES;
            }
        }];
        if (hit) {
            return hit;
        } else {
            return self;            
        }
    } else {
        return nil;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    
    CGFloat x2 = self.frame.size.width / 2.;
    CGFloat y2 = self.frame.size.height / 2.;
    
    //平方差公式 是与中心点之间的距离
    double dis = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    //在以当前控件中心为圆心半径为当前控件宽度的院内
    if (dis <= self.frame.size.width / 2.) {
        return YES;
    } else {
        return NO;
    }
}
@end
