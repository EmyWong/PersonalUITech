//
//  ViewController.m
//  scrollImageView
//
//  Created by 王颜华 on 16/4/21.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (instancetype)init
{
    if (self = [super init]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"我的"] style:UIBarButtonItemStyleDone target:self action:@selector(Info:)];
    }
    return self;
}
- (void)Info:(id)sender
{
    NSLog(@"资料");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"对方正在输入";
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
    imgView.frame = self.view.frame;
    [self.view addSubview:imgView];
    
    
    [self stretchMethod1];
    [self stretchMethod2];
    [self stretchMethod3];
    [self stretchMethod4];
}
- (void)stretchMethod1
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"你爱我吗" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(5, 70, 100, 50);
    [self.view addSubview:btn];
    //加载图片
    UIImage * image = [UIImage imageNamed:@"白.png"];
    
    //设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    //设置端盖的值
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(top, left, bottom, right);
    
    //拉伸图片
    UIImage * newImage = [image resizableImageWithCapInsets:edgeInset];
    
    //设置按钮的北京图片
    [btn setBackgroundImage:newImage forState:(UIControlStateNormal)];
    
}
- (void)stretchMethod2
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"我爱你" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(self.view.frame.size.width-105, 150, 80, 50);
    [self.view addSubview:btn];
    
    //加载图片
    UIImage * image = [UIImage imageNamed:@"绿.png"];
    
    //设置左边端盖的宽度
    NSInteger leftCapWidth = image.size.width * 0.5;
    
    //设置上边端盖高度
    NSInteger topCapHeight = image.size.height * 0.5;
    
    //拉伸图片
    UIImage * newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    
    //设置按钮的背景图片
    [btn setBackgroundImage:newImage forState:(UIControlStateNormal)];
    
}

- (void)stretchMethod3
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"我不信，你根本不爱我!" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(5, 230, 240, 50);
    [self.view addSubview:btn];
    //加载图片
    UIImage * image = [UIImage imageNamed:@"白.png"];
    
    //设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    //设置端盖的值
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(top, left, bottom, right);
    //设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    //拉伸图片
    UIImage * newImage = [image resizableImageWithCapInsets:edgeInset resizingMode:mode];
    
    [btn setBackgroundImage:newImage forState:(UIControlStateNormal)];
    
}
- (void)stretchMethod4
{
   //在Images里面修改slicing属性
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"那是因为你并不爱我" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(self.view.frame.size.width-205, 310, 200, 50);
    [self.view addSubview:btn];
    
    //加载图片
    UIImage * image = [UIImage imageNamed:@"绿.png"];
    [btn setBackgroundImage:image forState:(UIControlStateNormal)];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
