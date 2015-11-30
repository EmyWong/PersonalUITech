//
//  ViewController.m
//  SDWebImage进度条
//
//  Created by 王颜华 on 15/11/16.
//  Copyright © 2015年 第一小组. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@property (nonatomic,strong) UIImageView *imv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imv = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.imv];
    __block UIProgressView *pv;
    
    [self.imv sd_setImageWithURL:[NSURL URLWithString:@"http://p1.pichost.me/i/40/1639665.png"] placeholderImage:nil options:SDWebImageCacheMemoryOnly  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        pv = [[UIProgressView alloc]initWithProgressViewStyle:(UIProgressViewStyleDefault)];
        pv.frame = CGRectMake(0, 0, 400, 20);
        pv.center = self.view.center;
        NSLog(@"%ld,%ld",receivedSize,expectedSize);
        float currentProgress = (float)receivedSize/(float)expectedSize;
        pv.progress = currentProgress;
        [self.imv addSubview:pv];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [pv removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
