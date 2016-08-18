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
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
    }
}
//设置9个按钮的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
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
        if (CGRectContainsPoint(CGRectMake(frameX, frameY, wh, wh), point)) {
            return btn;
        }
    }
    return nil;
}
//设置Button被选中的状态
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [self pointWithTouches:touches];
    UIButton *btn = [self buttonWithPoint:point];
    if (btn != nil && btn.selected == false) {
        btn.selected = YES;
        [self.btns addObject:btn];
        [self.code appendString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    [self setNeedsDisplay];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.code = [[NSMutableString alloc]init];
    self.isEnd = NO;
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton *btn = self.btns[i];
        btn.selected = NO;
    }
    [self.btns removeAllObjects];
    CGPoint point = [self pointWithTouches:touches];
    UIButton *btn = [self buttonWithPoint:point];
    if (btn != nil && btn.selected == false) {
        btn.selected = YES;
        [self.btns addObject:btn];
        [self.code appendString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    [self setNeedsDisplay];
}
//使用touchend清空数据
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.btns.count < 3) {
        for (int i = 0; i < self.btns.count; i ++) {
            UIButton *btn = self.btns[i];
            btn.selected = NO;
        }
        [self.btns removeAllObjects];
    }
    self.isEnd = YES;
    [self setNeedsDisplay];
}
//优化 先判空
-(void)drawRect:(CGRect)rect
{
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
    [[UIColor colorWithRed:23/255.0 green:171/255.0 blue:227/255.0 alpha:1] set];
    [path setLineWidth:3];
    //设置连接风格
    [path setLineJoinStyle:(kCGLineJoinRound)];
    if (_isEnd == YES) {
        if (![self.code isEqualToString:self.password]) {
            [[UIColor redColor]set];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLabel" object:nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeLabel2" object:nil];
        }
    }
    [path stroke];
    
}
//Button点击事件
- (void)btnClick:(UIButton *)sender
{
    
}
//拼接用户的触摸路径 拼接字符串
//- (void)appendCode
//{
//    self.password = [[NSMutableString alloc]init];
//    for (UIButton *btn in self.btns) {
//        [self.password appendString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
//    }
//    NSLog(@"%@",self.password);
//}
@end
