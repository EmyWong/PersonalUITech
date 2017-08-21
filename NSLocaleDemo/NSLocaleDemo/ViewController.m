//
//  ViewController.m
//  NSLocaleDemo
//
//  Created by zhenghaoMAC on 2017/8/21.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //国际化文本
    //准确获取当前语言的方式
    NSString *strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    NSLog(@"%@",strLanguage);
    //通过NSLocalizedString()函数使用国际化消息
    self.label.text = NSLocalizedString(@"locale", nil);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
