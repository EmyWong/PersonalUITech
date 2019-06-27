//
//  ViewController.m
//  CALayerDemo1
//
//  Created by Aioute on 2019/6/21.
//  Copyright © 2019 Emy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CAShapeLayer *aniShapeLayer;
}

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *animationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /* CAShaperLayer是CAlayer为数不多的子类，作用是在屏幕上画出形状。
        strokeColor：笔画颜色。
        strokeStart：笔画开始位置。
        strokeEnd：笔画结束位置。
        fillColor：图形填充颜色。
        lineWidth：笔画宽度，即笔画的粗细程度。
        lineDashPattern：虚线模式。
        path：图形的路径。
        lineCap：笔画未闭合位置的形状。
     */
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 7;
    CGFloat ovalRadius = _loadingView.frame.size.width / 2. * 0.8;
    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_loadingView.frame.size.width/2 - ovalRadius , _loadingView.frame.size.height/2 - ovalRadius,  ovalRadius * 2,  ovalRadius * 2)].CGPath;
    ovalShapeLayer.path = path;
    //ovalShapeLayer在绘制圆形时只画整个圆形的五分之二
    ovalShapeLayer.strokeEnd = 0.4;
    //轮廓两头圆形
    ovalShapeLayer.lineCap = kCALineCapRound;
    [_loadingView.layer addSublayer:ovalShapeLayer];
    
    aniShapeLayer = [CAShapeLayer layer];
    aniShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    aniShapeLayer.fillColor = [UIColor clearColor].CGColor;
    aniShapeLayer.lineWidth = 7;
    CGFloat aniRadius = _animationView.frame.size.width / 2. * 0.8;
    CGPathRef aniPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_animationView.frame.size.width/2 - aniRadius , _animationView.frame.size.height/2 - aniRadius,  aniRadius * 2,  aniRadius * 2)].CGPath;
    aniShapeLayer.path = aniPath;
    aniShapeLayer.lineCap = kCALineCapRound;
    [_animationView.layer addSublayer:aniShapeLayer];
 
}

- (void)beginSimpleAnimation {
    /*
     transform.rotation：旋转动画。
     transform.ratation.x：按x轴旋转动画。
     transform.ratation.y：按y轴旋转动画。
     transform.ratation.z：按z轴旋转动画。
     transform.scale：按比例放大缩小动画。
     transform.scale.x：在x轴按比例放大缩小动画。
     transform.scale.y：在y轴按比例放大缩小动画。
     transform.scale.z：在z轴按比例放大缩小动画。
     position：移动位置动画。
     opacity：透明度动画。
     */
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 1.5;
    animation.fromValue = 0;
    animation.toValue = @(M_PI * 2);
    animation.repeatCount = HUGE;
    [_loadingView.layer addAnimation:animation forKey:nil];
}

- (void)beginComplexAnimation {
    /*
     strokeStartAnimate动画让绘制圆圈的笔画起始位置从–0.5开始，目的是让笔画起始绘制时等待一段时间，也就是起始位置延迟绘制。而strokeEndAnimate动画让绘制圆圈的笔画终止位置正常的从0绘制到1。这样一来笔画两头绘制的时间就会不一样，会有一个时间差，这样就有圆圈不断绘制又不断被擦除的效果。
     */
    //笔画开始动画
    CABasicAnimation *strokeStartAnimate = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    //画到0.5的时候笔画结束的动画执行形成在半圆处出现擦除效果0.25则为在1/4圆处出现擦除效果
    strokeStartAnimate.fromValue = @(-0.5);
    strokeStartAnimate.toValue = @(1);
    
    //笔画结束动画
    CABasicAnimation *strokeEndAnimate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //0代表绘制路径的起始位置
    strokeEndAnimate.fromValue = @(0);
    //1代表绘制路径的终止位置
    strokeEndAnimate.toValue = @(1);
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 1.5;
    group.repeatCount = HUGE;
    group.animations = @[strokeStartAnimate,strokeEndAnimate];
    //用_animationView.layer 添加动画 不可行 需要加在layer上
    [aniShapeLayer addAnimation:group forKey:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self beginSimpleAnimation];
    [self beginComplexAnimation];
}

@end
