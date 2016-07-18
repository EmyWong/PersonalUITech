//
//  UIMarqueeBarView.m
//  RunLabel
//
//  Created by 王颜华 on 16/7/18.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "UIMarqueeBarView.h"

@implementation UIMarqueeBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    [self setBackgroundColor:[UIColor lightGrayColor]];
    
    [self setClipsToBounds:YES];
    
    [self setOpaque:YES];
    
    UILabel *lblContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150 ,16)];
    
    [lblContent setText:@"这里是滚动条。。。。。"];
    
    [lblContent setTextColor:[UIColor whiteColor]];
    
    [lblContent setBackgroundColor:[UIColor clearColor]];
    
    [lblContent setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    
    [lblContent setNumberOfLines:1];
    
    [lblContent setOpaque:YES];
    
    
    
    [self addSubview:lblContent];
}
- (void)start

{
    
    if (self.viewContainer == NULL) {
        
        [self setupView];
        
    }
    [self startAnimation];
}
-(void)startAnimation

{
    
    [UIView beginAnimations:@"MarqueeBarAniamation" context:nil];
    
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    [UIView setAnimationDuration:25];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    
    
    CGRect viewFrame = self.viewContainer.frame;
    
    viewFrame.origin.x = -320;
    
    [self.viewContainer setFrame:viewFrame];
    
    
    
    [UIView commitAnimations];
    
}



-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context

{
    
    CGRect viewFrame = self.viewContainer.frame;
    
    viewFrame.origin.x = 320;
    
    [self.viewContainer setFrame:viewFrame];
    
    [self startAnimation];
    
}
@end
