//
//  ViewController.m
//  MotionManagerDemo
//
//  Created by zhenghaoMAC on 2017/8/22.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController () {
    NSTimer *updateTimer;
}
@property (weak, nonatomic) IBOutlet UILabel *accelerometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *gyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *magnetometerLabel;
/*
    CMMotionManager大致可获取3种数据
    >>加速度数据：该数据通过CMAccelerometerData对象来表示。该对象只有一个CMAcceleration结构体类型的acceleration属性，该结构体属性包含x、y、z三个字段，分别代表设备在X、Y、Z轴方向检测到的加速度值。
    >>陀螺仪数据：该数据通过CMGyroData对象来表示。该对象只有一个CMRotationRate结构体类型的rotationRate属性，该结构体属性值包含x、y、z三个字段，分别代表设备围绕X、Y、Z轴转动的速度。
    >>磁场数据：该数据通过CMMagnetometerData对象来表示。该对象只有一个CMMagneticField结构体类型的magneticField属性，该结构体属性值包含x、y、z三个字段，分别代表设备在X、Y、Z轴方向检测到的磁场强度，以微特斯拉为单位。
    除此之外，CMAccelerometerData、CMGyroData、CMMagnetometerData有一个公共的父类：CMLogItem，该父类定义了timestamp属性，这意味着不管是加速度数据、陀螺仪数据还是磁场数据，都可通过timestamp属性来访问程序得到该数据的时间。

 */
@property (strong,nonatomic) CMMotionManager *motionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //通过代码块获取数据
//    [self getDataByCodeBlock];
    //通过主动请求获取数据
    [self getDataByRequest];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //启动定时器来周期性轮询加速度数据、陀螺仪数据、磁场数据
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateDisplay) userInfo:nil repeats:YES];
}

//基于代码块方式获取加速度数据、陀螺仪数据、磁场数据
- (void) getDataByCodeBlock {
    //创建CMMotionManager对象
    self.motionManager = [[CMMotionManager alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //如果CMMotionManager支持获取加速度数据
    if (self.motionManager.accelerometerAvailable) {
        //设置CMMotionManager的加速度数据更新频率为0.1秒
        self.motionManager.accelerometerUpdateInterval = 0.1;
        //使用代码块开始获取加速度数据
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            NSString *labelText;
            //如果发生了错误，error不为空
            if (error) {
                //停止获取加速度数据
                [self.motionManager stopAccelerometerUpdates];
                labelText = [NSString stringWithFormat:@"获取加速度数据出现错误:%@",error];
            } else {
                //分别获取系统在XYZ轴上的加速度数据
                labelText = [NSString stringWithFormat:@"加速度为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z];
            }
            //在主线程中更新accelerometerLabel的文本，显示加速度数据
            [self.accelerometerLabel performSelectorOnMainThread:@selector(setText:) withObject:labelText waitUntilDone:NO];
        }];
    } else {
        NSLog(@"该设备不支持获取加速度数据！");
    }
    
    //如果CMMotionManager支持获取陀螺仪数据
    if (self.motionManager.gyroAvailable) {
        //设置CMMotionManager的陀螺仪数据更新频率为0.1秒
        self.motionManager.gyroUpdateInterval = 0.1;
        //通过代码块开始获取陀螺仪数据
        [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            NSString *labelText;
            //如果发生了错误，error不为空
            if (error) {
                //停止获取陀螺仪数据
                [self.motionManager stopGyroUpdates];
                labelText = [NSString stringWithFormat:@"获取陀螺仪数据出现错误：%@",error];
            } else {
                //分别获取设备绕XYZ轴的转速
                labelText = [NSString stringWithFormat:@"绕各轴的转速为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z];
                
            }
            //在主线程中更新gyroLabel的文本，显示绕各轴的转速
            [self.gyroLabel performSelectorOnMainThread:@selector(setText:) withObject:labelText waitUntilDone:NO];
        }];
    } else {
        NSLog(@"该设备被不支持获取陀螺仪数据！");
    }
    
    //如果CMMotionManager支持获取磁场数据
    if (self.motionManager.magnetometerAvailable) {
        //设置CMMotionManager的磁场数据更新频率为0.1秒
        self.motionManager.magnetometerUpdateInterval = 0.1;
        //通过代码块开始获取磁场数据
        [self.motionManager startMagnetometerUpdatesToQueue:queue withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
            NSString *labelText;
            if (error) {
                [self.motionManager stopMagnetometerUpdates];
                labelText = [NSString stringWithFormat:@"获取磁场数据出现错误：%@",error];
            } else {
                //分别获取设备在XYZ轴的磁场强度
                labelText = [NSString stringWithFormat:@"各轴的磁场强度为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",magnetometerData.magneticField.x,magnetometerData.magneticField.y,magnetometerData.magneticField.z];
            }
            //在主线程中更新magnetometerLabel的文本，显示磁场数据
            [self.magnetometerLabel performSelectorOnMainThread:@selector(setText:) withObject:labelText waitUntilDone:NO];
        }];
    } else {
        NSLog(@"该设备被不支持获取磁场数据！");
    }
}

//主动请求获取加速度数据、陀螺仪数据、磁场数据
- (void)getDataByRequest {
    //创建CMMotionManager对象
    self.motionManager = [[CMMotionManager alloc] init];
    //如果CMMotionManager支持获取加速度数据
    if (self.motionManager.accelerometerAvailable) {
        [self.motionManager startAccelerometerUpdates];
    } else {
        NSLog(@"该设备不支持获取加速度数据！");
    }
    //如果CMMotionManager支持获取陀螺仪数据
    if (self.motionManager.gyroAvailable) {
        [self.motionManager startGyroUpdates];
    } else {
        NSLog(@"该设备不支持获取陀螺仪数据！");
    }
    //如果CMMotionManager支持获取磁场数据
    if (self.motionManager.magnetometerAvailable) {
        [self.motionManager startMagnetometerUpdates];
    } else {
        NSLog(@"该设备不支持获取磁场数据！");
    }
}

//
- (void)updateDisplay {
    //如果CMMotionManager的加速度数据可用
    if (self.motionManager.accelerometerAvailable) {
        //主动请求获取加速度数据
        CMAccelerometerData *accelerometerData = self.motionManager.accelerometerData;
        self.accelerometerLabel.text =[NSString stringWithFormat:@"加速度为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z];
    }
    //如果CMMotionManager的陀螺仪数据可用
    if (self.motionManager.gyroAvailable) {
        //主动请求获取陀螺仪数据
        CMGyroData *gyroData = self.motionManager.gyroData;
        self.gyroLabel.text = [NSString stringWithFormat:@"绕各轴的转速为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z];
    }
    //如果CMMotionManager的磁场数据可用
    if (self.motionManager.magnetometerAvailable) {
        CMMagnetometerData *magnetometerData = self.motionManager.magnetometerData;
        self.magnetometerLabel.text = [NSString stringWithFormat:@"各轴的磁场强度为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",magnetometerData.magneticField.x,magnetometerData.magneticField.y,magnetometerData.magneticField.z];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
