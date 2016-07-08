//
//  ViewController.h
//  HealthKitDemo
//
//  Created by 王颜华 on 16/7/8.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
@interface ViewController : UIViewController
@property (nonatomic,strong) HKHealthStore *healthStore;
@end

