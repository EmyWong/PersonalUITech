//
//  CustomTextView.m
//  Quartz2DDemo
//
//  Created by 王颜华 on 16/8/16.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

- (void)drawRect:(CGRect)rect
{
    NSString *str = @"不管开心与否\n每天都要努力生活\n爱自己\n爱家人";
    //设置文字的属性
    NSMutableDictionary * paras = [NSMutableDictionary dictionary];
    //设置字体大小
    paras[NSFontAttributeName] = [UIFont systemFontOfSize:40];
    //设置字体颜色
    paras[NSForegroundColorAttributeName] = [UIColor blackColor];
    //设置镂空渲染颜色
    paras[NSStrokeColorAttributeName] = [UIColor orangeColor];
    //设置镂空渲染宽度
    paras[NSStrokeWidthAttributeName] = @3;
    
    //创建阴影对象
    NSShadow *shodow = [[NSShadow alloc] init];
    //阴影颜色
    shodow.shadowColor = [UIColor yellowColor];
    //阴影偏移量
    shodow.shadowOffset = CGSizeMake(5, 6);
    //阴影的模糊半径
    shodow.shadowBlurRadius = 4;
    //苹果的富文本就是这样搞出来的
    paras[NSShadowAttributeName]  = shodow;
    [str drawAtPoint:CGPointZero withAttributes:paras];
}

@end
