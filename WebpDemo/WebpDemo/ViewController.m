//
//  ViewController.m
//  WebpDemo
//
//  Created by Emy on 2018/4/19.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int totalNumber;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://qiniu.chinatianxia.cn/video_9784_20180201160155.mp4"];
    
    //fps值为1时 15s的视频截取了15帧的图 fps值为5时 15s的视频截取了75帧的图
    [self splitVideo:url fps:5 completedBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            NSMutableArray *imageArr = [[NSMutableArray alloc] init];
            for (int i = 1; i < totalNumber; i++) {
                NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                NSString *filePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%d.png",i]];
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                [imageArr addObject:image];
            }
            //截取的图片变成gif动画展示出来
            imageView.animationImages = imageArr;
            imageView.animationDuration = 15;
            [imageView startAnimating];
            [self.view addSubview:imageView];
        });
    }];
}

- (void)assetGetThumImage:(CGFloat)second
{
    //从网络上获取需要在info.plist添加网络权限
    AVURLAsset *urlSet = [AVURLAsset assetWithURL:[NSURL URLWithString:@"http://qiniu.chinatianxia.cn/video_9784_20180201160155.mp4"]];
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlSet];
    
    NSError *error = nil;
    //缩略图创建时间 CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法
    CMTime time = CMTimeMake(second,10);
    //缩略图实际生成的时间
    CMTime actucalTime;
    //获取单帧图片
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:&actucalTime error:&error];
    if (error) {
        NSLog(@"截取视频图片失败:%@",error.localizedDescription);
    }
    CMTimeShow(actucalTime);
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    //保存到相册 需要在info.plist添加权限
    UIImageWriteToSavedPhotosAlbum(image,nil, nil,nil);
    CGImageRelease(cgImage);
    
    NSLog(@"视频截取成功");
}

/**
 *  把视频文件拆成图片保存在沙盒中
 *
 *  @param fileUrl        本地视频文件URL
 *  @param fps            拆分时按此帧率进行拆分
 *  @param completedBlock 所有帧被拆完成后回调
 */
- (void)splitVideo:(NSURL *)fileUrl fps:(float)fps completedBlock:(void(^)(void))completedBlock {
    if (!fileUrl) {
        return;
    }
    NSDictionary *optDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *avasset = [[AVURLAsset alloc] initWithURL:fileUrl options:optDict];
    
    CMTime cmtime = avasset.duration; //视频时间信息结构体
    Float64 durationSeconds = CMTimeGetSeconds(cmtime); //视频总秒数
    
    NSMutableArray *times = [NSMutableArray array];
    Float64 totalFrames = durationSeconds * fps; //获得视频总帧数
    totalNumber = (int)totalFrames;
    CMTime timeFrame;
    for (int i = 1; i <= totalFrames; i++) {
        timeFrame = CMTimeMake(i, fps); //第i帧  帧率
        NSValue *timeValue = [NSValue valueWithCMTime:timeFrame];
        [times addObject:timeValue];
    }
    
    NSLog(@"------- start");
    AVAssetImageGenerator *imgGenerator = [[AVAssetImageGenerator alloc] initWithAsset:avasset];
    //防止时间出现偏差
    imgGenerator.requestedTimeToleranceBefore = kCMTimeZero;
    imgGenerator.requestedTimeToleranceAfter = kCMTimeZero;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSInteger timesCount = [times count];
    
    //删除已经下载的图片 测试添加
    for (int i = 1; i <= totalNumber; i++) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%d.png",i]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
    //到此结束 以上是非必要代码
    
    [imgGenerator generateCGImagesAsynchronouslyForTimes:times completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        printf("current-----: %lld\n", requestedTime.value);
        switch (result) {
            case AVAssetImageGeneratorCancelled:
                NSLog(@"Cancelled");
                break;
            case AVAssetImageGeneratorFailed:
                NSLog(@"Failed");
                break;
            case AVAssetImageGeneratorSucceeded: {
                NSString *filePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%lld.png",requestedTime.value]];
                NSData *imgData = UIImagePNGRepresentation([UIImage imageWithCGImage:image]);
                [imgData writeToFile:filePath atomically:YES];
                if (requestedTime.value == timesCount) {
                    NSLog(@"completed");
                    if (completedBlock) {
                        completedBlock();
                    }
                }
            }
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
