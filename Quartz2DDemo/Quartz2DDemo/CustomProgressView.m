//
//  CustomProgressView.m
//  Quartz2DDemo
//
//  Created by 王颜华 on 16/8/16.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "CustomProgressView.h"

@implementation CustomProgressView
- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:100 startAngle:-M_PI_2 endAngle:(_progressValue / 100.0) *(2 * M_PI) - M_PI_2 clockwise:YES];
    [[UIColor redColor] set];
    [path setLineWidth:10];
    [path setLineCapStyle:(kCGLineCapRound)];
    [path stroke];
}

@end
