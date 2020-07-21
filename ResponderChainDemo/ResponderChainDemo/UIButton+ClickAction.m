//
//  UIButton+ClickAction.m
//  ResponderChainDemo
//
//  Created by Emy on 2020/7/16.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "UIButton+ClickAction.h"

#import <objc/runtime.h>

@implementation UIButton (ClickAction)

// recursively calls -pointInside:withEvent:. point is in the receiver's coordinate system
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    /**
     在系统的UIView中以下z四种事件不响应：
     1.隐藏(hidden=YES)的视图
     2.禁止用户操作(userInteractionEnabled=NO)的视图
     3.alpha<0.01的视图
     4.视图超出父视图的区域
     */
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    
    //扩大Button响应范围，该处修改也可以通过修改pointInside:withEvent:来实现
    /**
     CGRectInset(CGRect rect, CGFloat dx, CGFloat dy)中的三个参数
     rect：待操作的CGRect；
     dx：为正数时，向右平移dx，宽度缩小2dx。为负数时，向左平移dx，宽度增大2dx；
     dy：为正数是，向下平移dy，高度缩小2dy。为负数是，向上平移dy，高度增大2dy。
     CGRectContainsPoint(CGRect rect, CGPoint point)判断手势点击的坐标point(x,y)是否落在rect(x,y,w,h)内.在区域内返回YES,不在返回NO.
     */
    CGRect enlageRect = CGRectInset(self.bounds, -50, -50);
    if (!CGRectContainsPoint(enlageRect, point)) {
        return nil;
    }
    
    //从后向前遍历子视图，之所以会采取从后往前遍历子控件的方式寻找最合适的view只是为了做一些循环优化。因为相比较之下，后添加的view在上面，降低循环次数。
//    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
//        //按照子视图坐标系转换点的坐标
//        CGPoint converedPoint = [self convertPoint:point toView:subview];
//        UIView *fitView = [subview hitTest:converedPoint withEvent:event];
//        if (fitView) {
//            return fitView;
//        }
//    }
    
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    CGRect bounds = self.bounds;
//    bounds = CGRectInset(bounds, -50, -50);
//    // CGRectContainsPoint  判断点是否在矩形内
//    return CGRectContainsPoint(bounds, point);
    return [super pointInside:point withEvent:event];
}

@end
