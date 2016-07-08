//
//  ViewController.m
//  ImageMoveAnimationDemo
//
//  Created by 王颜华 on 16/5/3.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,retain) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)paly
{
    //定义一张图片，并创建一个图片对象
    UIImage *image = [UIImage imageNamed:@"nvtou.jpg"];

    //初始化定义的UIImageView
    self.imageView = [[UIImageView alloc]initWithImage:image];
    
    //设置方位与大小
    self.imageView.frame = CGRectMake(0, 0, 100, 100);
   
    //设置透明度
    self.imageView.alpha = 1.0;
    
    //设置背景色
    self.imageView.backgroundColor = [UIColor blackColor];
 
    //添加视图
    [self.view addSubview:self.imageView];
    
    //开始动画
    [UIView beginAnimations:@"wusuowei" context:(__bridge void * _Nullable)(self.imageView)];
    
    //设置播放时间
    [UIView setAnimationDuration:3.0];
    
    //设置动画代理
    [UIView setAnimationDelegate:self];
    
    //右下角结束
    //重设方位与大小
    self.imageView.frame = CGRectMake(250, 0, 100, 100);
    
    //重设透明度
    self.imageView.alpha = 0.0;
    
    //结束动画
    [UIView commitAnimations];
    
    
}
@end
