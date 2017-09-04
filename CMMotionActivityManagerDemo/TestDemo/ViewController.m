//
//  ViewController.m
//  TestDemo
//
//  Created by zhenghaoMAC on 2017/8/29.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (nonatomic,retain) CMMotionActivityManager *motionActivityManager;
@property (nonatomic,retain) NSDateFormatter *dateFormater;
@property (weak, nonatomic) IBOutlet UILabel *currentStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *confidenceLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.motionActivityManager=[[CMMotionActivityManager alloc]init];
    self.dateFormater = [[NSDateFormatter alloc] init];
    self.dateFormater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    __weak typeof (self)weakSelf = self;
    [self.motionActivityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity *activity)
     {
         weakSelf.timeStampLabel.text = [weakSelf.dateFormater stringFromDate:[NSDate date]];
         
         if (activity.unknown) {
             weakSelf.currentStateLabel.text = @"未知状态";
         } else if (activity.walking) {
             weakSelf.currentStateLabel.text = @"步行";
         } else if (activity.running) {
             weakSelf.currentStateLabel.text = @"跑步";
         } else if (activity.automotive) {
             weakSelf.currentStateLabel.text = @"驾车";
         } else if (activity.stationary) {
             weakSelf.currentStateLabel.text = @"静止";
         }
         
         if (activity.confidence == CMMotionActivityConfidenceLow) {
             weakSelf.confidenceLabel.text = @"准确度  低";
         } else if (activity.confidence == CMMotionActivityConfidenceMedium) {
             weakSelf.confidenceLabel.text = @"准确度  中";
         } else if (activity.confidence == CMMotionActivityConfidenceHigh) {
             weakSelf.confidenceLabel.text = @"准确度  高";
         }
         
     }];
}
@end
