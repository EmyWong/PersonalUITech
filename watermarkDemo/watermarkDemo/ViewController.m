//
//  ViewController.m
//  watermarkDemo
//
//  Created by Administrator on 2017/12/21.
//  Copyright © 2017年 Rannie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img = [UIImage imageNamed:@"weixiao.jpg"];
    UIImage *logoImg = [UIImage imageNamed:@"weibo.png"];
    
    UIImage *newImg = [self watermarkImage:img withWatermarkImage:logoImg withWatermarkString:@"@王颜华" withFontSize:20];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgView.image = newImg;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    
    imgView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveToLocal:)];
    [imgView addGestureRecognizer:longPress];
}

- (void)saveToLocal:(UILongPressGestureRecognizer *)sender {
    UIImageView *imgView2 = (UIImageView *)sender.view;
    [self saveImageToPhotos:imgView2.image];
}

//给图片加文字水印和图片水印 仿微博 可自行修改
-(UIImage *)watermarkImage:(UIImage *)img withWatermarkImage:(UIImage *)watermarkImage withWatermarkString:(NSString *)watermarkString withFontSize:(CGFloat)fontSize

{
    
    int w = img.size.width;
    int h = img.size.height;
    
    //铺一张空白画布 原图size
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    
    //将原图画在画布上
    [img drawInRect:CGRectMake(0,0 , w, h)];
    
    //设置段落格式为局右对齐
    NSMutableParagraphStyle *paragraph=[[NSMutableParagraphStyle alloc]init];
    paragraph.alignment=NSTextAlignmentRight;
    
    //设置字体字典
    NSDictionary *attr = @{
                           NSFontAttributeName: [UIFont systemFontOfSize:fontSize],  //设置字体
                           NSForegroundColorAttributeName : [UIColor whiteColor ],  //设置字体颜色
                           NSParagraphStyleAttributeName:paragraph //设置段落格式
                           };
    //获取字符串按照格式得到的Size
    CGSize stringSize = [watermarkString sizeWithAttributes:attr];
    
    //将水印画在画布右下角（可自行调整），按照它的size
    [watermarkString drawInRect:CGRectMake(w - stringSize.width, h - stringSize.height,stringSize.width,stringSize.height) withAttributes:attr];
    //将水印图片画在文字水印的前面
    [watermarkImage drawInRect:CGRectMake(w - stringSize.width - stringSize.height, h - stringSize.height, stringSize.height, stringSize.height)];
    
    //画完时候存成新的Image
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束绘画
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

/**
 *  将图片添加到本地相册
 */

- (void)saveImageToPhotos:(UIImage*)savedImage

{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                          
                                                    message:msg
                          
                                                   delegate:self
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
