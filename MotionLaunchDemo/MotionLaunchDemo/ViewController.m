//
//  ViewController.m
//  MotionLaunchDemo
//
//  Created by 王颜华 on 16/8/17.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"
#import "SpeedDialView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.label.text = @"请输入手势密码";
    self.label.textColor = [UIColor darkGrayColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLabel) name:@"changeLabel" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLabel2) name:@"changeLabel2" object:nil];
    SpeedDialView *view = [[SpeedDialView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - self.view.frame.size.width, self.view.frame.size.width, self.view.frame.size.width)];
    view.password = @"1345";
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
 
    
}
- (void)changeLabel
{
    self.label.text = @"密码输入错误";
    self.label.textColor = [UIColor redColor];
}
- (void)changeLabel2
{
    self.label.text = @"恭喜，密码输入正确";
    self.label.textColor = [UIColor greenColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
