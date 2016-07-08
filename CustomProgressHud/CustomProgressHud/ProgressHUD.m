//
//  ProgressHUD.m
//  CustomProgressHud
//
//  Created by 王颜华 on 16/4/18.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

#import "ProgressHUD.h"

@implementation ProgressHUD


- (instancetype)init
{
    self.activityView = [[ProgressViewWithActivityView alloc]initWithFrame:CGRectZero];
    
    self.tintColor = [UIColor orangeColor];
    
    self.bgColor = [UIColor whiteColor];
    

    return self;
}
//设置父视图
- (ProgressHUD *)inView:(UIView *)inView
{
    self.superView = inView;
    return self;
}
//渲染颜色
- (ProgressHUD *)tintColor:(UIColor *)color
{
    self.tintColor = color;
    return self;
}
//背景颜色
- (ProgressHUD *)bgcolor:(UIColor *)color
{
    self.bgColor = color;
    return self;
}
//
- (ProgressHUD *)show
{
    [self showActivityView];
    return self;
}

- (void)showActivityView
{
    if (self.superView == nil) {
        return;
    }
    else
    {
        self.activityView.alpha = 0;
        self.activityView.frame = self.superView.bounds;
        self.activityView.bgView.backgroundColor = self.bgColor;
        self.activityView.activityView.color = self.tintColor;
        
        [self.superView  addSubview:self.activityView];
        
        self.isShowing = YES;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.activityView.alpha = 1;
        }];
    }
}
-(ProgressHUD *)finish
{
    [self finishActivityView];
    self.isShowing = NO;
    return self;
}
- (void)finishActivityView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.activityView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.activityView removeFromSuperview];
    }];
}
@end
