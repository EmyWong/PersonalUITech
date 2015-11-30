//
//  ThirdViewController.m
//  Copy&Cut
//
//  Created by 王颜华 on 15/11/29.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

-(void)viewDidAppear:(BOOL)animated
{
    if ([[UIPasteboard generalPasteboard].string containsString:@"我"]) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"他说" message:@"我爱你" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"我也爱你" style:(UIAlertActionStyleDefault) handler:nil];
        [alertView addAction:action];
        
        [self presentViewController:alertView animated:YES completion:nil];
    }
    else
    {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"剪贴板" message:[UIPasteboard generalPasteboard].string preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:nil];
        [alertView addAction:action];
        
        [self presentViewController:alertView animated:YES completion:nil];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
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
