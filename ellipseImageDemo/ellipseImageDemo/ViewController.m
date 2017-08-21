//
//  ViewController.m
//  ellipseImageDemo
//
//  Created by Dareway on 16/8/23.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCircleImageView];

}
//设置椭圆照片
- (void)setEllipseImageView
{
    UIImage * srcImg =[UIImage imageNamed:@"image"];
    CGFloat width = srcImg.size.width;
    CGFloat height = srcImg.size.height;
    //开始绘制图片
    UIGraphicsBeginImageContext(srcImg.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    ////绘制Clip区域
    //我的图片是120*160
    CGContextAddEllipseInRect(gc, CGRectMake(0, 0,120, 160)); //椭圆
    CGContextClosePath(gc);
    CGContextClip(gc);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(gc, 0, height);
    CGContextScaleCTM(gc, 1, -1);
    CGContextDrawImage(gc, CGRectMake(0, 0, width, height), [srcImg CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * view =[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 120, 160)];
    view.center = self.view.center;
    [view setImage:destImg];
    [self.view addSubview:view];

}
//设置圆形照片
- (void)setCircleImageView
{
    UIImage *image =[UIImage imageNamed:@"image"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center = self.view.center;
    imageView.image = image;
    imageView.layer.cornerRadius = 50;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    //裁剪
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
