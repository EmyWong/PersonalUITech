//
//  ViewController.m
//  YHSegmentController
//
//  Created by 王颜华 on 16/4/18.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.segmentView = [[YHSegmentView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.segmentView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
