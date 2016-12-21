//
//  dottedLineView.m
//  dottedLineDemo
//
//  Created by Dareway on 2016/12/19.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "dottedLineView.h"

@implementation dottedLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置线条颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor redColor].CGColor);
    //设置线条宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置线条绘制起点
    CGContextMoveToPoint(currentContext, 50, 50);
    //添加线条从起点（50，50）到终点（50，100）
    CGContextAddLineToPoint(currentContext, 50, 100);
    //添加线条从起点（50，100）到终点（self.frame.size.width - 50，100）
    CGContextAddLineToPoint(currentContext, self.frame.size.width - 50, 100);
    //添加线条从起点（self.frame.size.width - 50，100）到终点（self.frame.size.width - 50，150）
    CGContextAddLineToPoint(currentContext, self.frame.size.width - 50, 50);

    //如果不加下面👇两句话会是普通的直线
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制9个点（虚线长度）再绘制3个点（虚线间隔）
    CGFloat arr[] = {3,3};
    //下面最后一个参数“2”代表arr[]的个数。
    CGContextSetLineDash(currentContext, 0, arr, 2);
    //绘制结果
    //— — - - - - - - - - - - - - - -
    

    //一切都准备好了，开始绘制吧！
    CGContextDrawPath(currentContext, kCGPathStroke);
}

@end
