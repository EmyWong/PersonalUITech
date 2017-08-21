//
//  YHCustomMenuView.m
//  YHCustomMenu
//
//  Created by zhenghaoMAC on 2017/8/17.
//  Copyright © 2017年 zhenghaoMAC. All rights reserved.
//

#import "YHCustomMenuView.h"
@interface YHCustomMenuView ()
//彩色覆盖视图
@property (nonatomic, retain) UIView *colorfulView;
//白色底图的彩色线条
@property (nonatomic, retain) UIView *lineView;

@end

@implementation YHCustomMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllSubViews];
    }
    return self;
}

//添加所有的子视图
- (void)addAllSubViews {
    //所有的frame基于父视图设计
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.lineView =[[UIView alloc] initWithFrame:CGRectMake(width-5,0, 5, height)];\
    
    self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(width * 0.35,height *0.35, width *0.3, width *0.3)];
    self.iconImgView.userInteractionEnabled = YES;
    
    self.colorfulView = [[UIView alloc] initWithFrame:CGRectMake(-width, 0,width , height)];
    
    [self addSubview:self.lineView];
    [self addSubview:self.colorfulView];
    [self addSubview:self.iconImgView];
    [self bringSubviewToFront:self.iconImgView];
    
}
//设置图标的时候需要使其能够被渲染颜色 方便动画中的变色
- (void)setIconImg:(UIImage *)iconImg {
    UIImage *img = [iconImg imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    self.iconImgView.image = img;
    
}
//统一设置主题颜色 使其看起来和谐美观
- (void)setThemeColor:(UIColor *)themeColor {
    self.lineView.backgroundColor = themeColor;
    self.colorfulView.backgroundColor = themeColor;
    [self.iconImgView setTintColor:themeColor];
}
@end
