//
//  ViewController.m
//  CoreImage
//
//  Created by 王颜华 on 15/11/30.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController *_imagePickerController;//系统照片选择控制器
    CIContext *_context;//Core Image上下文
    CIImage *_image;//我们要编辑的图像
    CIImage *_outputImage;//处理后的图像
    CIFilter *_colorControlsFilter;//色彩滤镜
}
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UISlider *Staturation;
@property (weak, nonatomic) IBOutlet UISlider *Brightness;
@property (weak, nonatomic) IBOutlet UISlider *Contrast;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化图片选择器
    _imagePickerController=[[UIImagePickerController alloc]init];
    _imagePickerController.delegate =self;
    
    
    
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SelectImage:)];
    [self.imgView addGestureRecognizer:tap];

    //饱和度滑竿
    _Staturation.minimumValue=0;
    _Staturation.maximumValue=2;
    _Staturation.value=1;
    [_Staturation addTarget:self action:@selector(changeStaturation:) forControlEvents:UIControlEventValueChanged];
    //亮度滑竿
    _Brightness.minimumValue=-1;
    _Brightness.maximumValue=1;
    _Brightness.value=0;
    [_Brightness addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventValueChanged];
    //对比度滑竿
    _Contrast.minimumValue=0;
    _Contrast.maximumValue=2;
    _Contrast.value=1;
    [_Contrast addTarget:self action:@selector(changeContrast:) forControlEvents:UIControlEventValueChanged];
    
    //初始化CIContext
    //创建基于CPU的图像上下文
    //    NSNumber *number=[NSNumber numberWithBool:YES];
    //    NSDictionary *option=[NSDictionary dictionaryWithObject:number forKey:kCIContextUseSoftwareRenderer];
    //    _context=[CIContext contextWithOptions:option];
    //使用GPU渲染，推荐,但注意GPU的CIContext无法跨应用访问，例如直接在UIImagePickerController的完成方法中调用上下文处理就会自动降级为CPU渲染，所以推荐现在完成方法中保存图像，然后在主程序中调用
    _context=[CIContext contextWithOptions:nil];
    //    EAGLContext *eaglContext=[[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES1];
    //    _context=[CIContext contextWithEAGLContext:eaglContext];//OpenGL优化过的图像上下文
    
    //取得滤镜
    _colorControlsFilter=[CIFilter filterWithName:@"CIColorControls"];
}

- (IBAction)SelectImage:(UIButton *)sender {
    
    //把Slider的值重置成默认值
    self.Staturation.value = 1;
    self.Brightness.value = 0;
    self.Contrast.value = 1;
    //打开图片选择器
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
- (IBAction)Save:(UIButton *)sender {
    //保存照片到相册
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, nil, nil, nil);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    [alert show];

}
#pragma mark 图片选择器选择图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //关闭图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
    //取得选择图片
    UIImage *selectedImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    self.imgView.image=selectedImage;
    //初始化CIImage源图像
    _image=[CIImage imageWithCGImage:selectedImage.CGImage];
    [_colorControlsFilter setValue:_image forKey:@"inputImage"];//设置滤镜的输入图片
}
#pragma mark 将输出图片设置到UIImageView
-(void)setImage{
    CIImage *outputImage= [_colorControlsFilter outputImage];//取得输出图像
    CGImageRef temp=[_context createCGImage:outputImage fromRect:[outputImage extent]];
    self.imgView.image=[UIImage imageWithCGImage:temp];//转化为CGImage显示在界面中
    
    CGImageRelease(temp);//释放CGImage对象
}

#pragma mark 调整饱和度
-(void)changeStaturation:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputSaturation"];//设置滤镜参数
    [self setImage];
}

#pragma mark 调整亮度
-(void)changeBrightness:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputBrightness"];
    [self setImage];
}

#pragma mark 调整对比度
-(void)changeContrast:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputContrast"];
    [self setImage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
