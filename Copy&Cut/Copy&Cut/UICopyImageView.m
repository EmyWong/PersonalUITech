//
//  UICopyImageView.m
//  Copy&Cut
//
//  Created by 王颜华 on 15/11/29.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "UICopyImageView.h"

@implementation UICopyImageView

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:) || action == @selector(paste:));
}

- (void)copy:(id)sender
{
//    系统用的粘贴板
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//    自己用的时候，需要自己创建
//    需要提供一个唯一的名字，一般使用倒写的域名：com.mycompany.myapp.pboard
//    后面的参数表示，如果不存在，是否创建一个
//    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:@"wangyanhua" create:YES];
    
    NSData *imgData = UIImagePNGRepresentation(self.image);
    pboard.image = [UIImage imageWithData:imgData];
     NSLog(@"%@",self.image);
    NSLog(@"%@",pboard.image);

}
- (void)paste:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    self.image = pboard.image;
    NSLog(@"%@",pboard.image);
}

//UIImageView是默认不接收事件的，我们需要自己添加touch事件
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
    //UIMenuItem *menu2 = [[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(paste:)];
    //[[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:menu,menu2, nil]];
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
