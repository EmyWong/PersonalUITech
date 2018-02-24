//
//  SwipeUpInteractiveTransition.h
//  VCTransitionDemo
//
//  Created by Rannie on 2018/2/24.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

//设定一个BOOL变量来表示是否处于切换过程中，这个布尔值将在监测到手势开始时呗设置，我们之后会在调用返回这个InteractiveTransition的时候用到
@property (nonatomic, assign) BOOL intracting;

- (void)wireToViewController:(UIViewController *)viewController;

@end
