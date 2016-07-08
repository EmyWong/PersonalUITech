//
//  ViewController.m
//  CheckFaceDemo
//
//  Created by 王颜华 on 16/7/7.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *aImage = [UIImage imageNamed:@"证件照.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 160)];
    imageView.center = self.view.center;
    imageView.layer.borderWidth = 1.0;
    imageView.layer.masksToBounds = YES;
    //自适应图片宽高比例
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = aImage;
    [self.view addSubview:imageView];
    
    CIImage* image = [CIImage imageWithCGImage:aImage.CGImage];
    
    NSDictionary  *opts = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                      forKey:CIDetectorAccuracy];
    
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:opts];
    
    //得到面部数据
    NSArray* features = [detector featuresInImage:image];
    for (CIFaceFeature *f in features)
    {
        CGRect aRect = f.bounds;
        NSLog(@"%.f, %.f, %.f, %.f", aRect.origin.x, aRect.origin.y, aRect.size.width, aRect.size.height);
        CGFloat yHeight = imageView.frame.size.height;
        //眼睛和嘴的位置
        if(f.hasLeftEyePosition)
        {
            NSLog(@"Left eye %g %g\n", f.leftEyePosition.x, f.leftEyePosition.y);
            UIView *leftEye = [[UIView alloc]initWithFrame:CGRectMake(f.leftEyePosition.x, yHeight - f.leftEyePosition.y, 5, 5)];
            leftEye.backgroundColor = [UIColor greenColor];
            leftEye.alpha = 0.5;
            [imageView addSubview:leftEye];
        }
        if(f.hasRightEyePosition)
        {
            NSLog(@"Right eye %g %g\n", f.rightEyePosition.x, f.rightEyePosition.y);
            UIView *rightEye = [[UIView alloc]initWithFrame:CGRectMake(f.rightEyePosition.x, yHeight - f.rightEyePosition.y, 5, 5)];
            rightEye.backgroundColor = [UIColor redColor];
            rightEye.alpha = 0.5;
            [imageView addSubview:rightEye];
        }
        if(f.hasMouthPosition)
        {
            NSLog(@"Mouth %g %g\n", f.mouthPosition.x, f.mouthPosition.y);
            UIView *Mouth = [[UIView alloc]initWithFrame:CGRectMake(f.mouthPosition.x, yHeight - f.mouthPosition.y, 5, 5)];
            Mouth.backgroundColor = [UIColor blueColor];
            Mouth.alpha = 0.5;
            [imageView addSubview:Mouth];
        }
        if (f.hasSmile) {
            UILabel *smile = [[UILabel alloc]initWithFrame:CGRectMake(10, 50,self.view.frame.size.width , 40)];
            smile.text = @"检测到人脸微笑";
            smile.textAlignment = NSTextAlignmentCenter;
            smile.font = [UIFont fontWithName:@"Helvetica Bold" size:20];
            [self.view addSubview:smile];
        }
        else
        {
            UILabel *smile = [[UILabel alloc]initWithFrame:CGRectMake(10, 50,self.view.frame.size.width , 40)];
            smile.text = @"未检测到人脸微笑";
            smile.textAlignment = NSTextAlignmentCenter;
            smile.font = [UIFont fontWithName:@"Helvetica Bold" size:20];
            [self.view addSubview:smile];

        }
    }
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
