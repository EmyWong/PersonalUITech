//
//  ViewController.m
//  ColorfulQRCodeDemo
//
//  Created by Dareway on 16/9/5.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeImage.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QRCodeImage *qrCodeImage = [QRCodeImage codeImageWithString:@"https://github.com/EmyWong/PersonalUITech"
                                                           size:200
                                                          color:[UIColor orangeColor]
                                ];
    UIImageView *qrImageView = [[UIImageView alloc]initWithImage:qrCodeImage];
    qrImageView.center = self.view.center;
    [self.view addSubview:qrImageView];
    self.ImageView = qrImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
