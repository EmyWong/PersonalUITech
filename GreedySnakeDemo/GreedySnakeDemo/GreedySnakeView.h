//
//  GreedySnakeView.h
//  GreedySnakeDemo
//
//  Created by zhenghaoMAC on 2017/8/18.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#define POINT_SIZE 25
#define WIDTH (int)([UIScreen mainScreen].bounds.size.width / POINT_SIZE - 1)
#define HEIGHT (int)(([UIScreen mainScreen].bounds.size.height - 50) / POINT_SIZE - 1)
typedef enum {
    kDown = 0,
    kLeft,
    kRight,
    kUp
}Orient;
@interface GreedySnakeView : UIView<UIAlertViewDelegate>
//定义蛇的移动方向
@property (nonatomic, assign) Orient orient;
//计时器
@property (nonatomic,retain) NSTimer *timer;
@end
