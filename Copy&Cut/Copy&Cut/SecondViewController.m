//
//  SecondViewController.m
//  Copy&Cut
//
//  Created by 王颜华 on 15/11/29.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "SecondViewController.h"
#import "EWCopyImageView.h"
#import "ThirdViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    EWCopyImageView *copyImg1 = [[EWCopyImageView alloc]initWithFrame:CGRectMake(10, 150, 150, 150)];
    copyImg1.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:copyImg1];
    EWCopyImageView *copyImg2 = [[EWCopyImageView alloc]initWithFrame:CGRectMake(170, 150, 150, 150)];
    copyImg2.image = [UIImage imageNamed:@"3"];
    [self.view addSubview:copyImg2];

    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeRoundedRect) ];
    button.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 30);
    [button setTitle:@"点我" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(transAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeRoundedRect) ];
    button2.frame = CGRectMake(10, 300, self.view.frame.size.width - 20, 30);
    [button2 setTitle:@"返回" forState:(UIControlStateNormal)];
    [button2 addTarget:self action:@selector(transsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button2];


    // Do any additional setup after loading the view.
}
- (void)transAction:(UIButton *)sender
{
    [self presentViewController:[ThirdViewController new] animated:YES completion:nil];
}
- (void)transsAction:(UIButton *)sender

{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
