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
    //如果计步服务可用
    if ([CMPedometer isStepCountingAvailable]) {
        //创建CMPedometer对象
        self.pedoMeter = [[CMPedometer alloc] init];
        //开始收集计步信息
        [self.pedoMeter startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            NSLog(@"%@",pedometerData.numberOfSteps);
            self.stepLabel.text = [NSString stringWithFormat:@"我已经走了%@步",pedometerData.numberOfSteps];
        }];
        //限定时间内获取计步数据
//        [self.pedoMeter queryPedometerDataFromDate:[NSDate date] toDate:[NSDate dateWithTimeIntervalSinceNow:10] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
//            NSLog(@"%@",pedometerData.numberOfSteps);
//        }];
    
    } else {
        NSLog(@"设备不可用");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
