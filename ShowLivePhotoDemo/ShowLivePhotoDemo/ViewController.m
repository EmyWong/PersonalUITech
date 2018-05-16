//
//  ViewController.m
//  ShowLivePhotoDemo
//
//  Created by Emy on 2018/5/16.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 20, self.view.frame.size.width, 30);
    [button setTitle:@"打开系统相册" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)openPicker:(UIButton *)sender {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    NSArray *mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeLivePhoto];
    ipc.mediaTypes = mediaTypes;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        PHLivePhoto *photo = [info objectForKey:UIImagePickerControllerLivePhoto];
        if (photo) { //LivePhoto
            for (UIView * view in self.view.subviews) {
                if ([view isKindOfClass:[UIImageView class]] || [view isKindOfClass:[PHLivePhotoView class]]) {
                    [view removeFromSuperview];
                }
            }
            PHLivePhotoView *photoView = [[PHLivePhotoView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 60)];
            photoView.livePhoto = photo;
            photoView.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:photoView];
            //持续数秒效果
//            [photoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleHint];
            //全部循环展示效果
//            [photoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleFull];
            //停止动画
            //[photoView stopPlayback];

        } else { //普通照片
            for (UIView * view in self.view.subviews) {
                if ([view isKindOfClass:[PHLivePhotoView class]] || [view isKindOfClass:[UIImageView class]]) {
                    [view removeFromSuperview];
                }
            }
            UIImageView *photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 60)];
            photoView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
            photoView.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:photoView];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
