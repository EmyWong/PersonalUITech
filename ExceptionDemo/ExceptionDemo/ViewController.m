//
//  ViewController.m
//  ExceptionDemo
//
//  Created by Emy on 2018/8/18.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *nilStr = nil;
    //测试异常是否执行
    [array addObject:nilStr];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
