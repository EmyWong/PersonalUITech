//
//  SubViewController.m
//  ResponderChainDemo
//
//  Created by Emy on 2020/7/16.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, 0, 100, 50);
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    {
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = CGRectMake(0, 100, 10, 10);
        Button.backgroundColor = [UIColor redColor];
        [Button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [Button setTitle:@"BUTTON1" forState:UIControlStateNormal];
        [self.view addSubview:Button];
    }
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, 300, 300)];
        backView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:backView];
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = CGRectMake(100, 100, 100, 100);
        Button.backgroundColor = [UIColor redColor];
        [Button addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
        [Button setTitle:@"BUTTON2" forState:UIControlStateNormal];
        [backView addSubview:Button];
    }
}

- (void)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)click:(UIButton *)sender {
    UIResponder *res = sender;
    while (res) {
        NSLog(@"****************BUTTON1***************\n%@",res);
        res = [res nextResponder];
    }
}

- (void)click2:(UIButton *)sender {
    UIResponder *res = sender;
    while (res) {
        NSLog(@"****************BUTTON2***************\n%@",res);
        res = [res nextResponder];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /**
     在响应链中，如果某个控件实现了touches方法且没有调用[super touchesBegan:touches withEvent:event]，那事件就由该控件处理不会再传递了，如果调用了就会把事件抛给响应链上的上一个响应者。
     */
    UIResponder *res = self.view;
    while (res) {
        NSLog(@"****************TOUCHES***************\n%@",res);
        res = [res nextResponder];
    }
    [super touchesBegan:touches withEvent:event];
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
