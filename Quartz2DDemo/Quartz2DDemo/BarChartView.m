//
//  BarChartView.m
//  Quartz2DDemo
//
//  Created by 王颜华 on 16/8/16.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "BarChartView.h"
@interface BarChartView()
@property (nonatomic,retain) NSArray *nums;
@end
@implementation BarChartView
- (NSArray *)nums
{
    if (!_nums) {
        self.nums = @[@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80"];
    }
    return _nums;
}
- (void)drawRect:(CGRect)rect
{
    //1.获取图形上下文
    CGContextRef ctz = UIGraphicsGetCurrentContext();
    //2.绘制图像
    //设置间距
    CGFloat margin = 30;
    //当柱状图的数量多于5的时候缩小它们的间距
    if (self.nums.count > 5) {
        margin = 10;
    }
    //柱状图的宽度 = （ view的宽度 - 间隔的总宽度 ）/ 柱状图的个数
    CGFloat width = (rect.size.width - (self.nums.count + 1) *margin) / self.nums.count;
    for (int i = 0; i < self.nums.count; i++) {
        
        //求出 每一个数字所占的比例
        CGFloat num = [self.nums[i] floatValue]/100;
        //起点位置
        CGFloat x = margin + (width + margin) * i ;
        CGFloat y = rect.size.height * (1 - num);
        CGFloat height = rect.size.height * num;
        
        CGRect rectA = CGRectMake(x, y, width, height);
        CGContextAddRect(ctz, rectA);
        
        CGFloat randRed = arc4random_uniform(256)/255.0;
        CGFloat randGreen = arc4random_uniform(256)/255.0;
        CGFloat randBlue = arc4random_uniform(256)/255.0;
        UIColor *randomColor = [UIColor colorWithRed:randRed green:randGreen blue:randBlue alpha:1];
        
        [randomColor set];
        //渲染
        CGContextFillPath(ctz);
       
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
