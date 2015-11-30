//
//  ViewController.m
//  SpringAnimation
//
//  Created by 王颜华 on 15/11/28.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIImage *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.image = [UIImage imageNamed:@"wangyanhua.png"];
    self.imgView.center = self.view.center;
    self.imgView.image = self.image;
    [self.view addSubview:self.imgView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
    self.imgView.userInteractionEnabled = YES;
    [self.imgView addGestureRecognizer:tap];
}

#pragma mark 弹簧动画
- (void)viewWillAppear:(BOOL)animated
{
    self.imgView.center =CGPointMake(self.imgView.center.x,self.imgView.center.y + 30);
    self.imgView.alpha = 0;
}
- (void)viewDidAppear:(BOOL)animated
{
    //usingSpringWithDamping：弹簧动画的阻尼值，也就是相当于摩擦力的大小。该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
    //initialSpringVelocity：弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果。
    [UIView animateWithDuration:1 delay:0.5 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:(UIViewAnimationOptionAllowUserInteraction) animations:^{
        self.imgView.center = CGPointMake(self.imgView.center.x, self.imgView.center.y - 30);
        self.imgView.alpha = 1;
    } completion:nil];
}

#pragma mark 人机交互式动画
- (void)TapAction:(UITapGestureRecognizer *)sender
{
    //让UIImageView变胖一点
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:(UIViewAnimationOptionAllowUserInteraction) animations:^{
        self.imgView.bounds = CGRectMake(self.imgView.bounds.origin.x, self.imgView.bounds.origin.y, self.imgView.bounds.size.width + 10, self.imgView.bounds.size.height + 10);
    } completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end