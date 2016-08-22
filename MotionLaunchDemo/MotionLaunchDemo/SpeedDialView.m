//
//  SpeedDialView.m
//  MotionLaunchDemo
//
//  Created by 王颜华 on 16/8/17.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "SpeedDialView.h"

@implementation SpeedDialView
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
//懒加载
- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [[NSMutableArray alloc]init];
    }
    return _btns;
}
//创建9个按钮
- (void)setUpBasicUI
{
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.tag = i;
        [self addSubview:btn];
    }
}
//设置9个按钮的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    //这个方法只运行一次 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setUpBasicUI];
        
    });
    //经典的9宫格算法
    int totalColume = 3;
    CGFloat bWidth = 74;
    CGFloat bHeight = bWidth;
    CGFloat margin = (self.frame.size.width - bWidth * totalColume)/(totalColume + 1);
    
    for (int i = 0; i< self.subviews.count; i++) {
        int currentRow = i/totalColume;
        int currentColumn = i%totalColume;
        CGFloat originX = margin + (currentColumn * (margin + bWidth));
        CGFloat originY = currentRow * (margin + bHeight);
        //设置Button的外观和大小
        UIButton *btn = self.subviews[i];
        [btn setImage:[UIImage imageNamed:@"xv"] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"shi"] forState:(UIControlStateSelected)];
        btn.contentMode = UIViewContentModeCenter;
        btn.userInteractionEnabled = false;
        btn.frame = CGRectMake(originX, originY, bWidth, bHeight);
        
    }
    
    
}
//获取当前的触摸点的坐标
- (CGPoint)pointWithTouches:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    return point;
}
//判断当前点在不在Button中
- (UIButton *)buttonWithPoint:(CGPoint)point
{
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat wh = btn.frame.size.width - 5;
        //找到Button中心附近25*25的面积
        CGFloat frameX = btn.center.x - wh * 0.5;
        CGFloat frameY = btn.center.y - wh * 0.5;
        //判断这个点在button中心附近25*25的面积内的话就是它了
        if (CGRectContainsPoint(CGRectMake(frameX, frameY, wh, wh), point)) {
            return btn;
        }
    }
    return nil;
}
//设置Button被选中的状态
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //当触摸开始的时候将之前的痕迹抹掉 重新开始
    self.code = [[NSMutableString alloc]init];
    self.isEnd = NO;
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton *btn = self.btns[i];
        btn.selected = NO;
    }
    [self.btns removeAllObjects];
    //找到touch到的点的位置（此处只有一个点 就是开始的那个点）
    CGPoint point = [self pointWithTouches:touches];
    //判断这个点所在的Button
    UIButton *btn = [self buttonWithPoint:point];
    if (btn != nil && btn.selected == false) {
        btn.selected = YES;
        //把button加到数组中
        [self.btns addObject:btn];
        //并记录走过的路线 用Button的tag拼接出的字符串
        [self.code appendString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //找到touch到的点的位置
    CGPoint point = [self pointWithTouches:touches];
    //判断这个点所在的Button
    UIButton *btn = [self buttonWithPoint:point];
    if (btn != nil && btn.selected == false) {
        btn.selected = YES;
        //把button加到数组中
        [self.btns addObject:btn];
        //并记录走过的路线 用Button的tag拼接出的字符串
        [self.code appendString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    [self setNeedsDisplay];
}

//使用touchend清空数据
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //绘制选中的按钮少于3个的时候没有轨迹记录
    if (self.btns.count < 3) {
        for (int i = 0; i < self.btns.count; i ++) {
            UIButton *btn = self.btns[i];
            btn.selected = NO;
        }
        [self.btns removeAllObjects];
    }
    else
    {
        //标志 结束
        self.isEnd = YES;
    }
    [self setNeedsDisplay];
}
//优化 先判空
-(void)drawRect:(CGRect)rect
{
    //如果没有选择的button 则不绘图
    if (self.btns.count == 0) {
        return;
    }
    //使用贝塞尔曲线绘制路线
    UIBezierPath * path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton *btn = self.btns[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }
        else
        {
            [path addLineToPoint:btn.center];
        }
    }
    //设置线的颜色
    [[UIColor colorWithRed:23/255.0 green:171/255.0 blue:227/255.0 alpha:1] set];
    //设置线的宽度
    [path setLineWidth:3];
    //设置连接风格
    [path setLineJoinStyle:(kCGLineJoinRound)];
    //判断是否结束 在touchEnd方法中更改isEnd的值
    if (_isEnd == YES) {
        if (![self.code isEqualToString:self.password]) {
            //修改Path的颜色
            [[UIColor redColor]set];
            //发送通知 提醒ViewController更改Label上的文字
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLabel" object:nil];
        }
        else
        {
            //发送通知 提醒ViewController更改Label上的文字
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeLabel2" object:nil];
        }
    }
    //渲染
    [path stroke];
    
}
@end
//拼接用户的触摸路径 拼接字符串
//- (void)appendCode
//{
//    self.password = [[NSMutableString alloc]init];
//    for (UIButton *btn in self.btns) {
//        [self.password appendString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
//    }
//    NSLog(@"%@",self.password);
//}
