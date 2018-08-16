//
//  ViewController.m
//  CustomButton
//
//  Created by Emy on 2018/8/16.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"

@interface ViewController ()
{
    CustomButton *button;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    //创建一个只有中心圆形区域可以响应点击事件的Button
    button = [[CustomButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)doAction:(UIButton *)sender {
    NSLog(@"click");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
