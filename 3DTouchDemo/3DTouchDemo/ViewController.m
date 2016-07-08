//
//  ViewController.m
//  3DTouchDemo
//
//  Created by 王颜华 on 16/4/15.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)share:(UIButton *)sender {

    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}
- (IBAction)like:(UIButton *)sender {

    [self.navigationController pushViewController:[ThirdViewController new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
