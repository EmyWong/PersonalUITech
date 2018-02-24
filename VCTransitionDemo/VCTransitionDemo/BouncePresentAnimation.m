//
//  BouncePresentAnimation.m
//  VCTransitionDemo
//
//  Created by Rannie on 2018/2/23.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "BouncePresentAnimation.h"

@implementation BouncePresentAnimation

#pragma mark - UIViewControllerAnimatedTransitioning

//系统给出一个切换上下文transitionContext,我们根据上下文环境返回这个切换多需要的花费时间，一般就返回动画的时间就好了，SDK会用这个时间来在百分比驱动的切换中进行真的计算，后面在详细展开）
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}

//在进行切换的时候将调用该方法，我们对于切换时的UIView的设置和动画都在这个方法中完成。
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //1.得到参与切换的两个ViewController的信息，使用context拿到它们的参照，
    //ViewControllerForKey提供一个key返回对应的VC， UITransitionContextToViewControllerKey是将要切入的VC，UITransitionContextFromViewControllerKey是将要切出的VC。
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //2.对于要呈现的VC，我们希望它从屏幕下方出现，因此将初始位置设置为屏幕的下边缘
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //finalFrameForViewController是某个VC的最终位置，initialFrameForViewController是某个VC的初始位置
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
    //3.将view添加到containerView中
    //此处containerView是VC切换所发生的view容器，开发者应该将切出的view移除，将切入的view加入到该containerView中
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    //4.开始动画。这里的动画时间长度和切换时间长度一致都是0.8s。usingSpringWithDamping的UIView动画API是iOS7新加入的，描述了一个模拟弹簧动作的动画曲线。（此处注意UIView动画在iOS7种新添加的Category：UIViewKeyframeAnimations）
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        //5.在动画结束后我们必须向context报告VC切换完成，是否成功。（这里的动画切换种，没有失败的可能性，因此直接pass一个YES过去）
        [transitionContext completeTransition:YES];
    }];
}
@end
