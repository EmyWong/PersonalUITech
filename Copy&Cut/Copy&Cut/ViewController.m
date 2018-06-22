//
//  ViewController.m
//  Copy&Cut
//
//  Created by 王颜华 on 15/11/29.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "ViewController.h"
#import "EWCopyLabel.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EWCopyLabel *label = [[EWCopyLabel alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 30)];
    label.text = @"我爱你";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    EWCopyLabel *label1 = [[EWCopyLabel alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 30)];
    label1.text = @"哈哈哈";
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeRoundedRect) ];
    button.frame = CGRectMake(10, 150, self.view.frame.size.width - 20, 30);
    [button setTitle:@"点我" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(transAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

- (void)transAction:(UIButton *)sender
{
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
