//
//  ViewController.m
//  YHCustomMenu
//
//  Created by zhenghaoMAC on 2017/8/17.
//  Copyright © 2017年 zhenghaoMAC. All rights reserved.
//

#import "ViewController.h"
#import "YHCustomMenu.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化一个自定义菜单
    YHCustomMenu *view = [[YHCustomMenu alloc] initWithFrame:CGRectMake(0, 20, (self.view.frame.size.height - 20)/7, self.view.frame.size.height-20)];
    //设置菜单的按钮的个数
    view.number = 7;
    //设置菜单中按钮的图标 个数可以>=按钮个数
    view.iconImgArr = @[@"SSW.png",@"GXW.png",@"MMW.png",@"DYW.png",@"WZW.png",@"SJW.png",@"JGW.png"];
    //设置菜单中按钮的主题颜色 个数可以>=按钮个数
    view.themeColorArr = @[[UIColor colorWithRed:127/255. green:127/255. blue:127/255. alpha:1],[UIColor colorWithRed:217/255. green:31/255. blue:14/255. alpha:1],[UIColor colorWithRed:231/255. green:84/255. blue:36/255. alpha:1],[UIColor colorWithRed:223/255. green:176/255. blue:37/255. alpha:1],[UIColor colorWithRed:41/255. green:150/255. blue:205/255. alpha:1],[UIColor colorWithRed:22/255. green:60/255. blue:171/255. alpha:1],[UIColor colorWithRed:64/255. green:161/255. blue:73/255. alpha:1]];
    //设置默认选中页为第二页
    view.defaultIndex = 2;
    //添加到视图上
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
