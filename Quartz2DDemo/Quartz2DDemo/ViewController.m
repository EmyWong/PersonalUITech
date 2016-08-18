//
//  ViewController.m
//  Quartz2DDemo
//
//  Created by 王颜华 on 16/8/16.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "CustomProgressView.h"
#import "PieView.h"
#import "BarChartView.h"
#import "CustomImageView.h"
#import "CustomTextView.h"
@interface ViewController ()
@property (nonatomic,retain) UISlider *slider;
@property (nonatomic,retain) CustomProgressView *progressView;
@property (nonatomic,retain) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBarChartView];
}
//绘制富文本
- (void)addTextView
{
    CustomTextView *view = [[CustomTextView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];

}
//增加 绘制ImageView
- (void)addCustomImageView
{
    CustomImageView *view = [[CustomImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}
//增加 柱状图
- (void)addBarChartView
{
    BarChartView *view = [[BarChartView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}
//增加 扇形视图
- (void)addPieView
{
    PieView *pie = [[PieView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    pie.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pie];
}
//增加 进度视图
- (void)addProgressView
{
    self.progressView = [[CustomProgressView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    self.progressView.backgroundColor = [UIColor whiteColor];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    self.label.center = self.progressView.center;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.progressView addSubview:self.label];
    
    [self.view addSubview:self.progressView];
    
    
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(10, 500, self.view.frame.size.width - 20, 50)];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 100;
    [self.slider addTarget:self action:@selector(changeValue:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.slider];
}
- (void)changeValue:(UISlider *)sender
{
    self.progressView.progressValue = sender.value;
    self.label.text = [NSString stringWithFormat:@"%.f%%",sender.value];
}
//增加 自定义视图
- (void)addCustomView
{
    CustomView *view = [[CustomView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
