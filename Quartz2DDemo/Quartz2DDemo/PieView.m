//
//  PieView.m
//  Quartz2DDemo
//
//  Created by 王颜华 on 16/8/16.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "PieView.h"
@interface PieView ()
@property (nonatomic,retain) NSArray *nums;
@property (nonatomic,assign) NSInteger total;
@end
@implementation PieView
- (NSInteger)total
{
    if (_total == 0) {
        for (int i = 0; i < self.nums.count ; i ++) {
            _total += [self.nums[i] integerValue];
        }
    }
    return _total;
}
- (NSArray *)nums
{
    if (!_nums) {
        self.nums = @[@"10",@"20",@"30",@"40"];
    }
    return _nums;
}
- (void)drawRect:(CGRect)rect
{
    //绘制一个饼图
    CGFloat radius = 150;
    CGFloat startA = 0;
    CGFloat endA = 0;
    
    for (int i = 0; i < self.nums.count; i++) {
        NSNumber *num = self.nums[i];
        startA = endA;
        endA = startA + [num floatValue]/self.total * (2 * M_PI);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:self.center];
        
        CGFloat randRed = arc4random_uniform(256)/255.0;
        CGFloat randGreen = arc4random_uniform(256)/255.0;
        CGFloat randBlue = arc4random_uniform(256)/255.0;
        UIColor *randomColor = [UIColor colorWithRed:randRed green:randGreen blue:randBlue alpha:1];
        [randomColor set];
        
        [path fill];
    }
}

@end
