//
//  ViewController.m
//  RunLabel
//
//  Created by 王颜华 on 16/7/18.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"
#import "UIMarqueeBarView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIMarqueeBarView *view = [[UIMarqueeBarView alloc]initWithFrame:CGRectMake(0, 64, 100, 20)];
//    view.viewContainer = self.view;
//    [view start];
//    [self.view addSubview:view];
    AutoScrollLabel *autoScrollLabel = [[AutoScrollLabel alloc]initWithFrame:CGRectMake(0, 44, 100, 10)];
    autoScrollLabel.text = @"Hi Mom!  How are you?  I really ought to write more often.";
    autoScrollLabel.center = self.view.center;
    autoScrollLabel.textColor = [UIColor blackColor];
    [self.view addSubview:autoScrollLabel];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
