//
//  ViewController.m
//  Multi-TargetDemo
//
//  Created by Dareway on 2016/11/21.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
#ifdef Taget2
    self.view.backgroundColor = [UIColor blueColor];
#endif
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
