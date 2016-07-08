//
//  ViewController.m
//  libqrencodeDemo
//
//  Created by 王颜华 on 16/7/7.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"
#import "TimerDisappearAlertView.h"
#define kScreenW self.view.frame.size.width
@interface ViewController ()
@property (nonatomic,retain) UITextField *textField;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, kScreenW-20, 40)];
    label.text = @"二维码生成器";
    label.font = [UIFont fontWithName:@"Helvetica Bold" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 90, kScreenW - 20, 40)];
    self.textField.placeholder = @"请输入想生成二维码的文字";
    self.textField.borderStyle = UITextBorderStyleLine;
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 140, kScreenW - 20,kScreenW - 20)];
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.imageView.image = [UIImage imageNamed:@"default.png"];
    [self.view addSubview:self.imageView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapSaveImageToIphone)];
    [self.imageView addGestureRecognizer:longPress];
    self.imageView.userInteractionEnabled = YES;

    
    self.button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.button.frame = CGRectMake(10, kScreenW +130, kScreenW -20, 40);
    [self.button setTitle:@"生成二维码" forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(QRCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    [textField resignFirstResponder];
    
    return YES;
    
}
//生成二维码
- (void)QRCodeAction
{
    if ([self.textField.text isEqualToString:@""]) {
        self.imageView.image = [UIImage imageNamed:@"null.png"];
    }
    else
    {
    self.imageView.image = [QRCodeGenerator qrImageForString:self.textField.text imageSize:kScreenW - 20];
    }

}
//保存至本地
- (void)tapSaveImageToIphone{
    
    UIAlertController *alertController = [[UIAlertController alloc]init];
    
    UIAlertAction *cancel  = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存至相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    [alertController addAction:cancel];
    [alertController addAction:save];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo
{
    if (error == nil) {
        
        TimerDisappearAlertView *alert = [[TimerDisappearAlertView alloc]initWithTitle:@"保存成功"];
        [alert show];
        
    }else{
        
        
        TimerDisappearAlertView *alert = [[TimerDisappearAlertView alloc]initWithTitle:@"保存失败"];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
