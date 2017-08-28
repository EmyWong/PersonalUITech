//
//  ViewController.m
//  CMAttitudeDemo
//
//  Created by zhenghaoMAC on 2017/8/28.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
{
    NSTimer *updateTimer;
}
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UILabel *showField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建CMMotionManager对象
    self.motionManager = [[CMMotionManager alloc] init];
    //如果可以获取设备的动作信息
    if (self.motionManager.deviceMotionAvailable) {
        //开始更新设备的动作信息
        [self.motionManager startDeviceMotionUpdates];
    } else {
        NSLog(@"该设备的deviceMotion不可用");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //使用定时器周期性获取设备移动信息
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateDisplay) userInfo:nil repeats:YES];
    [updateTimer fire];
}

- (void)updateDisplay {
    if (self.motionManager.deviceMotionAvailable) {
        //获取设备移动信息
        CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;
        NSMutableString *str = [NSMutableString stringWithFormat:@"devuceMotion信息为：\n"];
        
        [str appendString:@"---attitude信息---\n"];
        [str appendFormat:@"attitude的yaw：%+.2f\n",deviceMotion.attitude.yaw];
        [str appendFormat:@"attitude的pitch：%+.2f\n",deviceMotion.attitude.pitch];
        [str appendFormat:@"attitude的roll：%+.2f\n",deviceMotion.attitude.roll];
        
        [str appendFormat:@"---rotationRate信息---\n"];
        [str appendFormat:@"rotationRate的X：%+.2f\n",deviceMotion.rotationRate.x];
        [str appendFormat:@"rotationRate的Y：%+.2f\n",deviceMotion.rotationRate.y];
        [str appendFormat:@"rotationRate的Z：%+.2f\n",deviceMotion.rotationRate.z];
        
        [str appendFormat:@"---gravity信息---\n"];
        [str appendFormat:@"gravity的X：%+.2f\n",deviceMotion.gravity.x];
        [str appendFormat:@"gravity的Y：%+.2f\n",deviceMotion.gravity.y];
        [str appendFormat:@"gravity的Z：%+.2f\n",deviceMotion.gravity.z];
        
        [str appendString:@"---magneticField信息---\n"];
        [str appendFormat:@"magneticField的X：%+.2f\n",deviceMotion.magneticField.field.x];
        [str appendFormat:@"magneticField的Y：%+.2f\n",deviceMotion.magneticField.field.y];
        [str appendFormat:@"magneticField的Z：%+.2f\n",deviceMotion.magneticField.field.z];
        self.showField.text = str;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
