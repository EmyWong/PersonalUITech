//
//  EnlageButtonView.m
//  ResponderChainDemo
//
//  Created by Emy on 2020/7/20.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "EnlageButtonView.h"

@interface EnlageButtonView ()

@property (nonatomic, strong) UIButton *Button;

@end

@implementation EnlageButtonView

@synthesize Button;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(0, 0, 10, 10);
    Button.center = self.center;
    Button.backgroundColor = [UIColor darkGrayColor];
    [Button setTitle:@"B" forState:UIControlStateNormal];
    Button.titleLabel.font = [UIFont systemFontOfSize:12];
    [Button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Button];
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"扩大按钮点击范围：%s",__FUNCTION__);
}

//点击这个view的任意位置都可以执行Button的点击事件，在某种程度上扩大了button的点击范围
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.userInteractionEnabled == NO || self.alpha <= 0.01 || self.hidden) {
        return nil;
    }
    
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    
    return CGRectContainsPoint(self.bounds, point) ? Button : nil;
}

@end
