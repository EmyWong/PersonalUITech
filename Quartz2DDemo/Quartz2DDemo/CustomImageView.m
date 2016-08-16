//
//  CustomImageView.m
//  Quartz2DDemo
//
//  Created by 王颜华 on 16/8/16.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView
-(void)drawRect:(CGRect)rect
{
    //剪切图片，超出的图片位置都要剪切掉！必须要在绘制之前写，否则无效
//    UIRectClip(CGRectMake(0, 0, 100, 50));
    
    UIImage *image = [UIImage imageNamed:@"image"];
    
    //独立
    //在什么范围内（原图大小）
    [image drawInRect:rect];
    
    //在哪个位置开始画
    [image drawAtPoint:CGPointMake(10, 10)];
    
    //平铺
    [image drawAsPatternInRect:rect];
}


@end
