//
//  ViewController.m
//  YingSheImageView
//
//  Created by 王颜华 on 16/7/4.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"
#define kReflectOpacity 0.1
#define kReflectDistance 10
@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIImage  *image = [UIImage imageNamed:@"nvtou.jpg"];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    //创建一个图层
    CALayer *reflectionLayer = [CALayer layer];
    //为图层的内容赋值，即imageView的图层的内容
    reflectionLayer.contents = [imageView layer].contents;
    //设置图层的透明度
    reflectionLayer.opacity = kReflectOpacity;
    //设置图层的frame，原点坐标为imageView的左上角顶点
    reflectionLayer.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
    //设置x,y,z三轴的缩放比例，三维坐标系的原点在imageView的中心，向右为x增加，向左为y增加，z轴垂直屏幕。负数表示，例如-x表示相对y-o-z 平面对三维模型做镜像。
    CATransform3D stransform = CATransform3DMakeScale(1.0f, -1.0f, 1.0f);
    //设置frame的偏移量
    CATransform3D transform = CATransform3DTranslate(stransform, 0, -kReflectDistance-imageView.frame.size.height, 0);
    //将编辑好的transform赋值给这个图层
    reflectionLayer.transform = transform;
    reflectionLayer.sublayerTransform = reflectionLayer.transform;
    //将这个图层添加到imageView图层上
    [[imageView layer]addSublayer:reflectionLayer];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
