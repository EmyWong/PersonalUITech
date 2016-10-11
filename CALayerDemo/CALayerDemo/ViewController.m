//
//  ViewController.m
//  CALayerDemo
//
//  Created by Dareway on 16/10/11.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //新建一个view用于对比
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    //用于改变layer的view
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
    view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view2];
    
    //设置layer的背景色为橙色
    view2.layer.backgroundColor = [UIColor orangeColor].CGColor;
    //设置layer的半径为20
    view2.layer.cornerRadius = 20.0;
    //设置layer的frame 横-2*10 竖-2*10
    view2.layer.frame = CGRectInset(view2.layer.frame, 10, 10);
    
    //添加一个带阴影效果的子层
    CALayer *subLayer = [CALayer layer];
    //子层 背景颜色
    subLayer.backgroundColor = [UIColor blueColor].CGColor;
    //子层 位置大小
    subLayer.frame = CGRectMake(15, 15, 250, 250);
    
    //阴影 偏移量 水平偏移5 垂直偏移5
    subLayer.shadowOffset = CGSizeMake(5, 5);
    //阴影 半径 0.5
    subLayer.shadowRadius = 0.5;
    //阴影 颜色 黑色
    subLayer.shadowColor = [UIColor blackColor].CGColor;
    //阴影 透明度
    subLayer.shadowOpacity = 0.5;
    
    //在view2的layer层上加子layer
    [view2.layer addSublayer:subLayer];
    
    //设置子层的内容为一张图片
    //    subLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"image.png"].CGImage);
    //设置子层的边框颜色为黑色
    subLayer.borderColor = [UIColor blackColor].CGColor;
    //设置子层的边框宽度为2.0
    subLayer.borderWidth = 2.0;
    subLayer.cornerRadius = 10.0;
    //    subLayer.masksToBounds = YES;
    
    
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = subLayer.bounds;
    imageLayer.cornerRadius = 10.0;
    imageLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"image.png"].CGImage);
    imageLayer.masksToBounds = YES;
    [subLayer addSublayer:imageLayer];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
