//
//  ViewController.m
//  ReadBrightnessDemo
//
//  Created by 王颜华 on 16/4/20.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UISlider *slider = [[UISlider alloc]initWithFrame:[UIScreen mainScreen].bounds];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    slider.value = app.b;
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(changeShine:) forControlEvents:(UIControlEventValueChanged)];

}

- (void)changeShine:(UISlider *)sender
{
    [[UIScreen mainScreen]setBrightness:sender.value];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
