//
//  ViewController.m
//  EditingTest
//
//  Created by 王颜华 on 15/11/25.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 50)];
    self.textField.borderStyle = UITextBorderStyleLine;
    self.textField.placeholder = @"请输入一些东西";
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-20, 20)];
    self.label.text = @"王颜华";
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.label.text = @"对方正在输入";
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.label.text = @"王颜华";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
