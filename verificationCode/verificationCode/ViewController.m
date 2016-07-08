//
//  ViewController.m
//  verificationCode
//
//  Created by 王颜华 on 15/12/3.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *changeArray;
    NSString *changeString;
    UILabel *yzmapictures;
    UITextField *textField;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    yzmapictures = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    yzmapictures.center = self.view.center;
    yzmapictures.numberOfLines = 0;
    yzmapictures.backgroundColor = [UIColor redColor];
    yzmapictures.textColor = [UIColor whiteColor];
    yzmapictures.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:yzmapictures];
    [self change];
    
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2 + 50, 100, 30)];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:textField];
    
    UIButton *commit = [UIButton buttonWithType:(UIButtonTypeCustom)];
    commit.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2 + 100, 100, 30);
    commit.backgroundColor = [UIColor blackColor];
    [commit setTitle:@"commit" forState:(UIControlStateNormal)];
    [commit addTarget:self action:@selector(commitAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:commit];
}
- (void)commitAction:(UIButton *)sender
{
    if ([textField.text isEqualToString:changeString]) {
        NSLog(@"校验合格");
    }
    else
    {
        NSLog(@"验证码不正确");
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self change];
}
- (void)change
{
    //用了大写字母,自己感觉要比小写好点吧，方法比较笨，嘿嘿
    changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
                    @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5]; //可变字符串，存取得到的随机数
    
    changeString = [[NSMutableString alloc] initWithCapacity:6]; //可变string，最终想要的验证码
    for(NSInteger i = 0; i < 6; i++) //得到四个随机字符，取四次，可自己设长度
    {
        NSInteger index = arc4random() % ([changeArray count] - 1);  //得到数组中随机数的下标
        getStr = [changeArray objectAtIndex:index];  //得到数组中随机数，赋给getStr
        
        changeString = (NSMutableString *)[changeString stringByAppendingString:getStr];
        yzmapictures.text = [NSString stringWithFormat:@"%@",changeString];
        CGFloat red= (arc4random()%256/255.0);
        CGFloat green= (arc4random()%256/255.0);
        CGFloat blue= (arc4random()%256/255.0);
        UIColor *redgreenblue=[UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        yzmapictures.backgroundColor = redgreenblue;
        
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
