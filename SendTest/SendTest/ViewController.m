//
//  ViewController.m
//  SendTest
//
//  Created by 王颜华 on 15/11/16.
//  Copyright © 2015年 第一小组. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
@interface ViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    btn.frame = CGRectMake(100,100 , 100, 100);
    [btn setTitle:@"发短信" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(SendMessage:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    btn1.frame = CGRectMake(100, 200, 100, 100);
    [btn1 setTitle:@"发邮件" forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(SendEmail:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    
    
}
- (void)SendMessage:(UIButton *)sender
{
    NSLog(@"发短信");
    MFMessageComposeViewController *message = [MFMessageComposeViewController new];
    message.body = @"在吗";
    message.recipients = @[@"15154298103"];
    message.messageComposeDelegate = self;
    [self presentViewController:message animated:YES completion:nil];
    
}
- (void)SendEmail:(UIButton *)sender
{
    if (![MFMailComposeViewController canSendMail]) {
        NSLog(@"你不能发邮件");
    }
    NSLog(@"发邮件");
    MFMailComposeViewController *email = [MFMailComposeViewController new];
    [email setSubject:@"iOS邮件测试"];
    [email setToRecipients:@[@"453132184@qq.com"]];
    [email setMessageBody:@"我的iOS邮件测试" isHTML:NO];
    [email setMailComposeDelegate:self];
    [self presentViewController:email animated:YES completion:nil];
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled) {
        NSLog(@"取消发送");
    }
    else if (result == MessageComposeResultFailed)
    {
        NSLog(@"发送失败");
    }
    else
    {
        NSLog(@"发送成功");
        
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MFMailComposeResultCancelled) {
        NSLog(@"取消发送");
    }
    else if (result == MFMailComposeResultFailed)
    {
        NSLog(@"发送失败");
    }
    else if (result == MFMailComposeResultSent)
    {
        NSLog(@"发送成功");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
