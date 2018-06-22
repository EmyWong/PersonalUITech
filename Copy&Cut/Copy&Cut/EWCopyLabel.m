//
//  UICopyLabel.m
//  Copy&Cut
//
//  Created by 王颜华 on 15/11/29.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "EWCopyLabel.h"

@implementation EWCopyLabel

//为了能接收到事件（能成为第一响应者）
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
//针对复制的操作覆盖两个方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:));
}
- (void)copy:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
    NSLog(@"%@",pasteboard.string);
}

//UILabel是默认不接收事件的，我们需要自己添加touch事件
- (void)attachTapHanlder
{
    //开启用户交互
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tap];
}
//处理tap事件，让菜单弹出来。
- (void)handleTap:(UITapGestureRecognizer *)sender
{
    [self becomeFirstResponder];
    //UIMenuItem *menu = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copy:)];
    //[[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:menu, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}
//绑定事件
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHanlder];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self attachTapHanlder];
}

@end
