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
@property (weak, nonatomic) IBOutlet SpeedDialView *speedDialView;

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
   
    self.speedDialView.password = @"1345";
 
    
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
