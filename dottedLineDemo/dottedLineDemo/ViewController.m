//
//  ViewController.m
//  dottedLineDemo
//
//  Created by Dareway on 2016/12/19.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"
#import "dottedLineView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addDottedView];
}

- (void)addDottedView {
    dottedLineView *view = [[dottedLineView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)drawByImageView {
    // 创建一个imageView 高度是你想要的虚线的高度 一般设为2
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 2)];
    // 调用方法 返回的iamge就是虚线
    lineImg.image = [self drawLineByImageView:lineImg];
    // 添加到控制器的view上
    [self.view addSubview:lineImg];
}

// 返回虚线image的方法
- (UIImage *)drawLineByImageView:(UIImageView *)imageView{
    //开始画线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 1是高度
    CGFloat lengths[] = {5,1};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor redColor].CGColor);
    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    CGContextMoveToPoint(line, 10, 2.0); //开始画线
    CGContextAddLineToPoint(line, kScreenWidth - 10, 2.0);
    
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
