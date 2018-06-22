//
//  ProgressViewWithActivityView.m
//  CustomProgressHud
//
//  Created by 王颜华 on 16/4/18.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

#import "ProgressViewWithActivityView.h"

@implementation ProgressViewWithActivityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    
    if (self) {
        //初始化两个属性
        self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        self.bgView = [[UIView alloc]initWithFrame:CGRectZero];
        
        [self setupAllViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    
    NSLog(@"initWithCoder is not been implemented");
    }
    return self;
}
- (void)setupAllViews
{
    //添加到view上
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.activityView];
    
    //对view进行美化
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 3);
    self.bgView.layer.shadowOpacity = 1;
    
    //开始转起来
    [self.activityView startAnimating];
}
//确定大小和位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0, 64, 64);
    self.bgView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.activityView.center = CGPointMake(self.bgView.frame.size.width/2, self.bgView.frame.size.height/2);
}
@end

