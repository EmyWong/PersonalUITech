//
//  ProgressHUD.h
//  CustomProgressHud
//
//  Created by 王颜华 on 16/4/18.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgressViewWithActivityView.h"
@interface ProgressHUD : NSObject

@property (nonatomic, strong) ProgressViewWithActivityView *activityView;
@property (nonatomic, strong) UIView * superView;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, assign) BOOL isShowing;

- (ProgressHUD *)inView:(UIView *)inView;
- (ProgressHUD *)tintColor:(UIColor *)color;
- (ProgressHUD *)bgcolor:(UIColor *)color;
- (ProgressHUD *)show;
- (ProgressHUD *)finish;
@end
