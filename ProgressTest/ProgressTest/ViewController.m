//
//  ViewController.m
//  ProgressTest
//
//  Created by 王颜华 on 15/11/16.
//  Copyright © 2015年 第一小组. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化 自由方法设置样式
    UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:(UIProgressViewStyleDefault)];
    //设置位置
    progressView.frame = CGRectMake(0, 0, self.view.frame.size.width-20, 20);
    progressView.center = self.view.center;
    //设置进度
    progressView.progress = 0;
    //设置它的轨道颜色
    //progressView.trackTintColor = [UIColor whiteColor];
    //设置它的轨道颜色
    //progressView.progressTintColor = [UIColor blueColor];
    //设置进度条进度的动画
    //[progressView setProgress:0.8 animated:YES];
    [self.view addSubview:progressView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
