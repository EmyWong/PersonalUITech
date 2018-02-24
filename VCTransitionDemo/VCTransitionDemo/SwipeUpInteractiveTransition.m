//
//  SwipeUpInteractiveTransition.m
//  VCTransitionDemo
//
//  Created by Rannie on 2018/2/24.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "SwipeUpInteractiveTransition.h"

@interface SwipeUpInteractiveTransition ()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;
@end

@implementation SwipeUpInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController {
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed {
    return  1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view.superview];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.intracting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            //向下滑动400px或以上为100%，每次手势状态变化时根据当前手势位置计算新的百分比
            CGFloat fraction = translation.y / 400.0;
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);
            
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            //当手势结束时，把正在切换的标设置回NO，然后进行判断。在2种我们设定了手势超过一半就认为应该结束手势，否则就应该返回原来状态，在这里使用shouldComplete判断，已决定这次transition是否应该结束。
            self.intracting = NO;
            if (!self.shouldComplete || sender.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
