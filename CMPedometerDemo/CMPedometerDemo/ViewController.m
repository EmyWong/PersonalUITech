//
//  ViewController.m
//  CMPedometerDemo
//
//  Created by zhenghaoMAC on 2017/8/29.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic, retain) CMPedometer *pedoMeter;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建CMPedometer对象
    self.pedoMeter = [[CMPedometer alloc] init];
}
- (IBAction)startCountStep:(id)sender {
    //判断是否可以支持获取步数
    if ([CMPedometer isStepCountingAvailable]) {
        //判断是否可以支持返回步行的距离
        //    if ([CMPedometer isDistanceAvailable]) {
        //判断是否可以支持爬楼梯的检测
        //    if ([CMPedometer isFloorCountingAvailable]) {
        
        //当你的步数有更新的时候，会触发这个方法，返回从某一时刻开始到现在所有的信息统计CMPedometerData。
        //其中CMPedometerData包含步数等信息，在下面使用的时候介绍。
        //值得一提的是这个方法不会实时返回结果，每次刷新数据大概一分钟左右。
        [self.pedoMeter startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            self.stepLabel.text = [NSString stringWithFormat:@"我已经走了%@步，距离%@米",pedometerData.numberOfSteps,pedometerData.distance];
        }];
        
    } else {
        NSLog(@"设备不可用");
    }
}

- (IBAction)stopCountStep:(UIButton *)sender {
    //停止收集计步信息
    [self.pedoMeter stopPedometerUpdates];
}
- (IBAction)lastWeek:(id)sender {
    //这个方法用来查询近7天内的任意时间段的CMPedometerData信息。
    //这个方法是当你请求的时候才会触发
    
    //我查询从今天0点到现在我走了多少步
    NSDate *startOfToday = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    [self.pedoMeter queryPedometerDataFromDate:startOfToday toDate:[NSDate dateWithTimeIntervalSinceNow:0] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        self.stepLabel.text = [NSString stringWithFormat:@"我已经走了%@步，距离%@米",pedometerData.numberOfSteps,pedometerData.distance];
    }];

}
@end
