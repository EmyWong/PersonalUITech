//
//  ViewController.m
//  GetDeviceDemo
//
//  Created by 王颜华 on 16/5/3.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "sys/utsname.h"
#import "sys/sysctl.h"
#define WScreen self.view.frame.size.width
#define WHeight self.view.frame.size.height
@interface ViewController ()
@property (nonatomic,retain) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    btn.frame = CGRectMake(WScreen/2 - 50, 20, 100, 30);
    [btn setTitle:@"显示设备信息" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(showDeviceInfo:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
}
- (void)showDeviceInfo:(UIButton *)sender
{
    if (self.label != nil) {
        [self.label removeFromSuperview];
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //获取APP名称
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    //获取APP版本号
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    UIDevice *device = [[UIDevice alloc] init];
    NSString *name = device.name;       //获取设备所有者的名称
    NSString *model = device.model;      //获取设备的类别
    NSString *type = device.localizedModel; //获取本地化版本
    NSString *systemName = device.systemName;   //获取当前运行的系统
    NSString *systemVersion = device.systemVersion;//获取当前系统的版本
    NSString *identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];//获取设备的唯一标识符
    //获取设备屏幕分辨率
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = rect.size.width * scale;
    CGFloat height = rect.size.height * scale;
    
    //获取运营商的信息
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    //获取当前网络类型
    NSString *mConnectType = [[NSString alloc] initWithFormat:@"%@",info.currentRadioAccessTechnology];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WScreen, WHeight - 50)];
    self.label.numberOfLines = 0;
    self.label.text = [NSString stringWithFormat:@"app名称：%@\napp版本：%@\n手机型号：%@\n设备所有者名称：%@\n设备的类别：%@\n本地化版本：%@\n当前运行的系统：%@\n当前系统的版本：%@\n\n唯一标识符：%@\n屏幕分辨率：%.0f*%.0f\n运营商：%@\n网络类型：%@\n",appName,appVersion,[self deviceVersion
                                                                                                                                                                                                            ],name,model,type,systemName,systemVersion,identifier,width,height,mCarrier,mConnectType];
    [self.view addSubview:self.label];
}
//获取设备字符串返回设备型号
- (NSString*)deviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}
//返回设备字符串
- (NSString *)deviceString{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
