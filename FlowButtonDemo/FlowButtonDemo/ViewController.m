//
//  ViewController.m
//  FlowButtonDemo
//
//  Created by Emy on 2019/8/27.
//  Copyright © 2019 Emy. All rights reserved.
//

#import "ViewController.h"
#import "FlowButton.h"

@interface ViewController () {
    UIView *flowView; //轮廓光View
    FlowButton *flowButton; //FlowButton
    UIView *flowView2; //轮廓光View
    FlowButton *flowButton2; //FlowButton
    NSTimer *timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:73.0 / 255.0 green:135.0 / 255.0 blue:244.0 / 255.0 alpha:1.0];
    
    {
        //轮廓光View
        flowView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
        //圆角 此处不加masksToBounds防止阴影被切掉
        flowView.layer.cornerRadius = 2.0;
        //背景颜色
        flowView.backgroundColor = [UIColor whiteColor];
        //阴影颜色
        flowView.layer.shadowColor = [UIColor whiteColor].CGColor;
        //阴影在四周包围
        flowView.layer.shadowOffset = CGSizeMake(0,0);
        //阴影透明度
        flowView.layer.shadowOpacity = 1.0;
        //阴影的半径
        flowView.layer.shadowRadius = 5;
        //View的透明度 默认是0.0
        flowView.alpha = 0.0;
        //添加到self.view上
        [self.view addSubview:flowView];
        
        //flowButton
        flowButton = [[FlowButton alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
        //设置Button的字体
        flowButton.flowLightBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.5f];
        //设置背景颜色
        flowButton.backgroundColor = [UIColor colorWithRed:242.0 / 255.0 green:2.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
        //设置Button的title
        [flowButton.flowLightBtn setTitle:NSLocalizedString(@"Purchase", nil) forState:UIControlStateNormal];
        //设置圆角
        flowButton.layer.cornerRadius = 2.0;
        flowButton.layer.masksToBounds = YES;
        //不能作为flowView的子视图存在 会一起执行透明度变化的动画
        [self.view addSubview:flowButton];
    }
    {
        //轮廓光View
        flowView2 = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 80, 50)];
        //圆角 此处不加masksToBounds防止阴影被切掉
        flowView2.layer.cornerRadius = 2.0;
        //背景颜色
        flowView2.backgroundColor = [UIColor whiteColor];
        //阴影颜色
        flowView2.layer.shadowColor = [UIColor whiteColor].CGColor;
        //阴影在四周包围
        flowView2.layer.shadowOffset = CGSizeMake(0,0);
        //阴影透明度
        flowView2.layer.shadowOpacity = 1.0;
        //阴影的半径
        flowView2.layer.shadowRadius = 5;
        //View的透明度 默认是0.0
        flowView2.alpha = 0.0;
        //添加到self.view上
        [self.view addSubview:flowView2];
        
        //flowButton
        flowButton2 = [[FlowButton alloc] initWithFrame:CGRectMake(100, 400, 80, 50)];
        //设置Button的字体
        flowButton2.flowLightBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.5f];
        //设置背景颜色
        flowButton2.backgroundColor = [UIColor colorWithRed:59.0 / 255.0 green:214.0 / 255.0 blue:73.0 / 255.0 alpha:1.0];
        //设置Button的title
        [flowButton2.flowLightBtn setTitle:NSLocalizedString(@"Purchase", nil) forState:UIControlStateNormal];
        //设置圆角
        flowButton2.layer.cornerRadius = 2.0;
        flowButton2.layer.masksToBounds = YES;
        //不能作为flowView的子视图存在 会一起执行透明度变化的动画
        [self.view addSubview:flowButton2];
    }
    
    //开启计时器每隔5s执行一次动画
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(showAnimations) userInfo:nil repeats:YES];
}

- (void)showAnimations {
    [self showAnimationsWithView:flowView Button:flowButton Width:200];
    [self showAnimationsWithView:flowView2 Button:flowButton2 Width:80];
}

//流光动画
- (void)showAnimationsWithView:(UIView *)backView Button:(FlowButton *)buttonView  Width:(CGFloat)buttonViewWidth {
    //轮廓光呼吸动画
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    //所改变属性的起始值
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    //所改变属性的结束时的值
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    //动画的时长
    opacityAnimation.duration = 1.0;
    //动画结束时是否执行逆动画
    opacityAnimation.autoreverses = NO;
    //重复的次数。不停重复设置为 HUGE_VALF
    opacityAnimation.repeatCount = 0;
    //为轮廓光View添加layer动画
    [backView.layer addAnimation:opacityAnimation forKey:@"opacity"];
    
    //流光动画
    //为flowLightImageView新建一个Layer作为遮罩层mask
    CALayer *maskLayer = [CALayer layer];
    UIImage *maskImage = [UIImage imageNamed:@"btnLightMask.png"];
    maskLayer.frame = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    //设置contents（一般该对象是一个CGImageRef对象，可通过contentsGravity属性设置图片展示模式，是平铺整个bounds还是等比例展示）。
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    //为了让maskLayer和flowLightImageView两个图层搭配出一个新的视觉效果，简单理解就是一个遮罩，mask图层区域外的任何区域不显示。
    buttonView.flowLightImageView.layer.mask = maskLayer;
    //将隐藏的流光ImageView显示出来
    buttonView.flowLightImageView.hidden = NO;
    
    //x轴方向的位移动画
    CABasicAnimation *flowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    //由于按钮可长可短 所以在这里需要进行判断
    CGFloat width = maskLayer.frame.size.width > buttonViewWidth ? maskLayer.frame.size.width : buttonViewWidth;
    //所改变属性的起始值
    flowAnimation.fromValue = [NSNumber numberWithFloat:- width / 2.];
    //所改变属性的结束时的值
    flowAnimation.toValue = [NSNumber numberWithFloat:buttonViewWidth];
    //动画的时长
    flowAnimation.duration = 1.0;
    //重复的次数。不停重复设置为 HUGE_VALF
    flowAnimation.repeatCount = 0;
    //防止动画结束后回到初始状态
    flowAnimation.removedOnCompletion = NO;
    flowAnimation.fillMode = kCAFillModeForwards;
    //添加动画
    [maskLayer addAnimation:flowAnimation forKey:@"transform.translation.x"];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //视图消失的时候将timer释放
    [timer invalidate];
    timer = nil;
}

@end
