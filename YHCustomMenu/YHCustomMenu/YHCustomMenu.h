//
//  YHCustomMenu.h
//  YHCustomMenu
//
//  Created by zhenghaoMAC on 2017/8/17.
//  Copyright © 2017年 zhenghaoMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHCustomMenuView.h"

@interface YHCustomMenu : UIView

//按钮的数量
@property (nonatomic, assign) NSInteger number;
//自定义图标
@property (nonatomic, strong) NSArray *iconImgArr;
//自定义颜色
@property (nonatomic, strong) NSArray *themeColorArr;
//默认选择页
@property (nonatomic, assign) NSInteger defaultIndex;

@end
