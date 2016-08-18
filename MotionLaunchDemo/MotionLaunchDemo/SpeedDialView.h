//
//  SpeedDialView.h
//  MotionLaunchDemo
//
//  Created by 王颜华 on 16/8/17.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeedDialView : UIView
//用来盛放选中的btn
@property (nonatomic,retain) NSMutableArray *btns;
//输入的密码
@property (nonatomic,strong) NSMutableString *code;
//正确密码
@property (nonatomic,strong) NSString *password;
//触摸是否结束
@property (nonatomic,assign) BOOL isEnd;
@end
