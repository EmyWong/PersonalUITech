//
//  GreedySnakeView.m
//  GreedySnakeDemo
//
//  Created by zhenghaoMAC on 2017/8/18.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "GreedySnakeView.h"
#import "CustomPoint.h"

@interface GreedySnakeView()
{
    // 代表游戏音效变量
    SystemSoundID gu;
    SystemSoundID crash;
    UIView *maskView;
}
//记录蛇的点，最后一个点代表蛇头
@property (nonatomic,retain) NSMutableArray *snakeData;
//定义食物所在的点
@property (nonatomic,retain) CustomPoint *foodsPoint;
//背景颜色
@property (nonatomic,retain) UIColor *bgColor;
@end
@implementation GreedySnakeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景颜色
        self.bgColor = [UIColor colorWithRed:1.0 green:206/255. blue:241/255. alpha:1];
        // 获取两个音效文件的的URL
        NSURL* guUrl = [[NSBundle mainBundle]
                        URLForResource:@"gu" withExtension:@"mp3"];
        NSURL* crashUrl = [[NSBundle mainBundle]
                           URLForResource:@"crash" withExtension:@"wav"];
        // 加载两个音效文件
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)guUrl , &gu);
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)crashUrl , &crash);
        //开始游戏
        [self startGame];
    }
    return self;
}

- (void)startGame {
    self.snakeData = [[NSMutableArray alloc] init];
    //CustomPoint 第一个参数控制位于水平第几格，第二个参数控制位于垂直第几格。
    for (int i = 1; i<6; i++) {
        CustomPoint *point = [[CustomPoint alloc]initWithX:i y:0];
        [self.snakeData addObject:point];
    }
    self.orient = kRight;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(move) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)move {
    // 除了蛇头受方向控制之外，其他点都是占它的前一个
    // 获取最后一个点，作为蛇头
    CustomPoint *first  = self.snakeData[_snakeData.count - 1];
    CustomPoint *head = [[CustomPoint alloc] initWithX:first.x y:first.y];
    
    switch (self.orient) {
        case kDown:
            head.y += 1;
            break;
            
        case kLeft:
            head.x -= 1;
            break;
            
        case kRight:
            head.x += 1;
            break;
            
        case kUp:
            head.y -= 1;
            break;
            
        default:
            break;
    }
    
    //假如每个Custom是20点的宽高，计算宽度为
    //蛇上下左右撞墙 或碰到自己的身体
    if (head.x < 0 || head.x > WIDTH - 1 || head.y < 0 || head.y > HEIGHT - 1 || [_snakeData containsObject:head]) {
        // 播放碰撞的音效
        AudioServicesPlaySystemSound(crash);
        [self addView];
        [self.timer invalidate];
    }
    //蛇头与食物点重合
    if ([head isEqual:_foodsPoint]) {
        // 播放吃食物的音效
        AudioServicesPlaySystemSound(gu);
        [_snakeData addObject:_foodsPoint];
        _foodsPoint = nil;
    } else {
        for (int i = 0; i < _snakeData.count - 1; i++) {
            //将第i个点的坐标设置为第i+1个点的坐标
            CustomPoint *curP = _snakeData[i];
            CustomPoint *nexP = _snakeData[i+1];
            curP.x = nexP.x;
            curP.y = nexP.y;
        }
        [_snakeData setObject:head atIndexedSubscript:(_snakeData.count - 1)];
    }
    
    //安放食物的位置
    if (_foodsPoint == nil) {
        while (true) {
            //取随机位置
            CustomPoint *newFoodsPoint = [[CustomPoint alloc] initWithX:(arc4random() % WIDTH) y:(arc4random() % HEIGHT)];
            //只有食物点与蛇的身体点不同的时候 才算成功
            if (![_snakeData containsObject:newFoodsPoint]) {
                _foodsPoint = newFoodsPoint;
                break;
            }
        }
    }
    
    [self setNeedsDisplay];
}
//定义绘制蛇头的方法
- (void)drawHeadInRect:(CGRect)rect context:(CGContextRef)ctx {
    CGContextBeginPath(ctx);
    //根据蛇头的方向，决定开口的角度
    CGFloat startAngle;
    switch (_orient) {
        case kUp:
            startAngle = M_PI * 7 / 4;
            break;
        case kDown:
            startAngle = M_PI * 3 / 4;
            break;
        case kLeft:
            startAngle = M_PI * 5 / 4;
            break;
        case kRight:
            startAngle = M_PI * 1 / 4;
            break;
        default:
            break;
    }
    //添加一段弧线作为路径
    CGContextAddArc(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect), POINT_SIZE / 2, startAngle, M_PI * 1.5 + startAngle , 0 );
    //将绘制点移动到中心
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect));
    //关闭路径
    CGContextClosePath(ctx);
    //绘制颜色
    CGContextFillPath(ctx);
}

- (void)drawRect:(CGRect)rect {
    //获取绘图API
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, CGRectMake(0, 0,WIDTH * POINT_SIZE , HEIGHT * POINT_SIZE));
    CGContextSetFillColorWithColor(ctx, [_bgColor CGColor]);
    //绘制背景
    CGContextFillRect(ctx, CGRectMake(0, 0, WIDTH * POINT_SIZE, HEIGHT * POINT_SIZE));
    //设置绘制蛇的填充颜色
    CGContextSetRGBFillColor(ctx, 153/255., 153/255., 153/255., 1);
    
    //遍历蛇的数据，绘制蛇的数据
    for (int i = 0; i < _snakeData.count; i++) {
        //为每个蛇的点，在屏幕上绘制一个圆点
        CustomPoint *cp = _snakeData[i];
        
        CGRect rect = CGRectMake(cp.x * POINT_SIZE, cp.y * POINT_SIZE, POINT_SIZE, POINT_SIZE);
        
        //绘制蛇尾巴，让蛇的尾巴小一点
        if (i < 4) {
            CGFloat inset = 4-i;
            CGContextFillEllipseInRect(ctx, CGRectInset(rect, inset, inset));
        }
        //如果是最后一个元素，代表蛇头，绘制蛇头
        else if ( i == _snakeData.count - 1) {
            [self drawHeadInRect:rect context:ctx];
        } else {
            CGContextFillEllipseInRect(ctx, rect);
        }
    }
    //绘制食物
    CGContextFillEllipseInRect(ctx, CGRectMake(_foodsPoint.x * POINT_SIZE, _foodsPoint.y * POINT_SIZE, POINT_SIZE, POINT_SIZE));
//    [_foodImage drawInRect:CGRectMake(_foodsPoint.x * POINT_SIZE, _foodsPoint.y * POINT_SIZE, POINT_SIZE, POINT_SIZE)];
}

- (void) addView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEBUTTON" object:nil];
    maskView = [[UIView alloc] initWithFrame:self.bounds];
    maskView.backgroundColor = self.bgColor;
    [self addSubview:maskView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
    label.text = [NSString stringWithFormat:@"本局您得了%lu分",(_snakeData.count - 5)];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1];
    label.center = CGPointMake(maskView.center.x, maskView.center.y - 60);
    label.font = [UIFont systemFontOfSize:30];
    [maskView addSubview:label];
    
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn2.frame = CGRectMake(0, 0, 200, 50);
    btn2.center = CGPointMake(maskView.center.x, maskView.center.y+35);
    btn2.backgroundColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1];
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds =  YES;
    [btn2 addTarget:self action:@selector(startGameAgain) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setTitle:@"再来一局" forState:(UIControlStateNormal)];
    [maskView addSubview:btn2];
}

- (void) startGameAgain {
    [maskView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWBUTTON" object:nil];
    [self startGame];
}
@end

