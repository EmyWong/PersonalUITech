//
//  CustomView.m
//  Quartz2DDemo
//
//  Created by 王颜华 on 16/8/16.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView
/*
 使用图形上下文画图，要遵循以下四个步骤
 1.获取图像上下文
 2.创建路径
 3.将路径添加到图形上下文（add）
 4.渲染图像上下文（fill，stroke）
 */


- (void)drawRect:(CGRect)rect
{
    [self drawFanShaped];
}
#pragma mark - 直接使用图形上下文画图
- (void)oneMethod
{
    //1.获取图形上下文，目前我们现在使用的都是UIGraphics开头，CoreGraphics，项目简称CG
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.描述路径
    //2.1 创建路径
    CGContextMoveToPoint(ctx, 10, 50);
    //2.2 添加线到一个点
    CGContextAddLineToPoint(ctx, 10,100);
    
    //3.完成路线
    CGContextStrokePath(ctx);

}
#pragma mark - 图形上下文 + CGPathRef画线
- (void)twoMethod
{
    //1.获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.使用path画线
    CGMutablePathRef path = CGPathCreateMutable();
    
    //3.添加点
    CGPathMoveToPoint(path, NULL, 20, 50);
    CGPathAddLineToPoint(path, NULL, 20, 100);
    
    //4.将path添加到图形上下文
    CGContextAddPath(ctx, path);
    
    //5.渲染上下文
    CGContextStrokePath(ctx);
}
#pragma mark - 贝塞尔曲线
- (void)threeMethod
{
    //1.创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //2.画线
    [path moveToPoint:CGPointMake(30, 50)];
    [path addLineToPoint:CGPointMake(30, 100)];
    
    //3.渲染
    [path stroke];
}
#pragma mark - 图形上下文 + 贝塞尔曲线
- (void)fourMethod
{
    //1.获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //3.画线
    [path moveToPoint:CGPointMake(40, 50)];
    [path addLineToPoint:CGPointMake(40, 100)];
    
    //4.将path添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    //5.渲染
    CGContextStrokePath(ctx);
}

#pragma mark - 画两个相交的线，并设置属性
- (void)drawTwoLineCrossSetAttribute
{
    //1.获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.将绘制路径，并且将其添加到图形上下文
    CGContextMoveToPoint(ctx, 123, 45);
    CGContextAddLineToPoint(ctx, 45, 80);
    
    //3.添加另一条线
    CGContextAddLineToPoint(ctx, 223, 159);
    
    //设置颜色
    [[UIColor greenColor] set];
    //设置线的宽度
    CGContextSetLineWidth(ctx, 10);
    //设置链接外的链接类型
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //设置线的头部方式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //4.渲染
    CGContextStrokePath(ctx);
}
#pragma mark - 画两个不相交的线，并且设置各自属性
- (void)drawTwoLineNoCrossSetAttribute
{
    //1.创建贝塞尔曲线路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //2.绘制路径
    [path moveToPoint:CGPointMake(12, 49)];
    [path addLineToPoint:CGPointMake(68, 34)];
    [[UIColor redColor] set];
    [path setLineWidth:5];
    //3.渲染
    [path stroke];
    
    //绘制第二条路径
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(145, 167)];
    [path2 addLineToPoint:CGPointMake(98, 34)];
    [[UIColor greenColor] set];
    [path2 setLineWidth:10];
    [path2 setLineCapStyle:kCGLineCapRound];
    [path2 stroke];
    
}
#pragma mark - 绘制曲线
- (void)drawQuadCurve
{
    //1.获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.设置起点
    CGContextMoveToPoint(ctx, 10, 50);
    
    /**
     *  添加曲线的五个参数
     *
     *  @param c#>   图形上下文
     *  @param cpx#> 将来要突出的x值
     *  @param cpy#> 要突出的y值
     *  @param x#>   曲线结束时的x
     *  @param y#>   曲线结束时的y
     */
    
    CGContextAddQuadCurveToPoint(ctx, 160, 300, 310, 50);
    
    //设置颜色
    [[UIColor redColor] set];
    //设置宽度
    CGContextSetLineWidth(ctx, 5);
    
    //3.渲染图层
    CGContextStrokePath(ctx);
}
#pragma mark - 绘制一个带有圆角边框的正方形
- (void)drawRoundSquare
{
    //绘制一个空心的圆角矩形
    //1.创建路径 贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 50, 100, 40) cornerRadius:5];
    //设置颜色
    [[UIColor redColor] set];
    //2.渲染
    [path stroke];
    
    //绘制一个实心的圆角正方形
    //1.创建路径 贝塞尔曲线
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 140, 100, 100) cornerRadius:5];
    //设置颜色
    [[UIColor orangeColor] set];
    //2.渲染
    [path2 fill];
    
    //绘制一个实心的圆
    //1.创建路径 贝塞尔曲线
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 290, 100, 100) cornerRadius:50];
    //设置颜色
    [[UIColor blueColor] set];
    //2.渲染
    [path3 fill];

}
#pragma mark - 绘制一个弧度曲线
- (void)drawCurve
{
    /**
     *  绘制弧度曲线
     *
     *  @param ArcCenter 曲线中心
     *  @param radius       半径
     *  @param startAngle 开始的弧度
     *  @param endAngle 结束的弧度
     *  @param clockwise YES顺时针，NO逆时针
     */
    
    //绘制一条半圆曲线
    //1.创建路径 贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:50 startAngle:0 endAngle:M_PI clockwise:YES];
    [[UIColor redColor] set];
    [path setLineWidth:10];
    [path setLineCapStyle:(kCGLineCapRound)];
    //2.渲染
    [path stroke];
    
    //绘制一条3/4圆曲线
    //1.创建路径 贝塞尔曲线
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 350) radius:50 startAngle:0 endAngle:270/360.0*(M_PI * 2) clockwise:YES];
    [[UIColor yellowColor] set];
    [path2 setLineWidth:10];
    [path2 setLineCapStyle:(kCGLineCapRound)];
    //2.渲染
    [path2 stroke];
    
    //绘制一个圆形曲线
    //1.创建路径 贝塞尔曲线
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 550) radius:50 startAngle:0 endAngle:(M_PI * 2) clockwise:YES];
    [[UIColor blueColor] set];
    [path3 setLineWidth:10];
    [path3 setLineCapStyle:(kCGLineCapRound)];
    //2.渲染
    [path3 stroke];
    
}
#pragma mark - 绘制扇形
- (void)drawFanShaped
{
    //1.获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //绘制曲线
    CGFloat centerX = 100;
    CGFloat centerY = 100;
    CGFloat radius = 50;
    //2.添加一根线
    CGContextMoveToPoint(ctx, centerX, centerY);
    CGContextAddArc(ctx, centerX, centerY, radius, M_PI, (230 / 360.0)*(M_PI * 2), NO);
    
    //3.关闭线段
    CGContextClosePath(ctx);
    //4.渲染
    CGContextFillPath(ctx);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
