//
//  FlowButton.m
//  FlowButtonDemo
//
//  Created by Emy on 2019/8/27.
//  Copyright © 2019 Emy. All rights reserved.
//

#import "FlowButton.h"

@implementation FlowButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //按钮
        self.flowLightBtn = [[UIButton alloc] init];
        //这里设置默认颜色 无需一致
        [self.flowLightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.flowLightBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        //添加约束必要条件
        self.flowLightBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.flowLightBtn];
        
        //流光
        self.flowLightImageView = [[UIImageView alloc] init];
        //设立设置默认颜色 无需一致
        self.flowLightImageView.backgroundColor = [UIColor whiteColor];
        //添加约束必要条件
        self.flowLightImageView.translatesAutoresizingMaskIntoConstraints = NO;
        //先将它隐藏 开启动画的时候再显示 没有动画的时候不需要添加轮廓光
        self.flowLightImageView.hidden = YES;
        //不能影响按钮的点击效果 有备无患
        self.flowLightImageView.userInteractionEnabled = YES;
        [self addSubview:self.flowLightImageView];
        
        //约束
        //flowLightBtn的Top与父视图的Top间距为0
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.flowLightBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        //flowLightBtn的Bottom与父视图的Bottom间距为0
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.flowLightBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        //flowLightBtn的Left与父视图的Left间距为0
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.flowLightBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        //flowLightBtn的Right与父视图的Right间距为0
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.flowLightBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        
        //flowLightImageView的Top与父视图的Top间距为0
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.flowLightImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        //flowLightImageView的Bottom与父视图的Bottom间距为0
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.flowLightImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        //flowLightImageView的Left与父视图的Left间距为0
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.flowLightImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        //flowLightImageView的Right与父视图的Right间距为0
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.flowLightImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    }
    return self;
}

@end
