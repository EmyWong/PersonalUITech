//
//  ViewController.m
//  UIBackBarButton
//
//  Created by 王颜华 on 15/11/28.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试用";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondViewController *secondVC = [SecondViewController new];
    
    
    //更改UINavigationController的返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    backButton.title = @"返回";
    [self.navigationItem setBackBarButtonItem:backButton];
    
    
    [self.navigationController pushViewController:secondVC animated:YES];
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
