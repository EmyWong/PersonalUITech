//
//  TimerDisappearAlertView.m
//  豆瓣
//
//  Created by lanou3g on 15/9/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TimerDisappearAlertView.h"

@implementation TimerDisappearAlertView



- (instancetype) initWithTitle:(NSString *)title{
    
    if (self = [super initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil]) {
        
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(alertAction:) userInfo:self repeats:YES];
    
    
    
//    [self show];
}

-(void)alertAction:(NSTimer *)timer{
    
    UIAlertView *alert = (UIAlertView *)[timer userInfo];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    alert = NULL;
    
    
}

//
//#pragma mark 定时消失的alertView
//- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
//{
//    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
//    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
//    promptAlert =NULL;
//
//}
//
//
//- (void)showAlert:(NSString *) _message{//时间
//    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:_message message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//
//
//
//    [NSTimer scheduledTimerWithTimeInterval:1.5f
//                                     target:self
//                                   selector:@selector(timerFireMethod:)
//                                   userInfo:promptAlert
//                                    repeats:YES];
//    [promptAlert show];
//}





@end
