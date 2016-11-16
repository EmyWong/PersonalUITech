//
//  ViewController.m
//  SSZipArchive
//
//  Created by Dareway on 16/11/8.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"
#import <SSZipArchive.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)downloadZip:(UIButton *)sender {
    [self downloadZip];
}
- (void)downloadZip
{
    //1.创建会话对象
    NSURLSession *session =[NSURLSession sharedSession];

    //2.确定请求路径
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://10.1.83.78:8080/bemms/maps/3710.zip"]];
    request.HTTPMethod = @"POST";
                                    
    //3.创建task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"******%@", cachePath);
        //5.1确定文件的全路径
        NSString *fullpath = [cachePath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@---%@",fullpath,[NSThread currentThread]);
            if (!error) {
                [data writeToFile:fullpath atomically:YES];
            }
        
        BOOL ok = [SSZipArchive unzipFileAtPath:fullpath toDestination:cachePath];
        NSLog(@"%@", @(ok));
    }];
                                  
    
    //5.启动task
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
