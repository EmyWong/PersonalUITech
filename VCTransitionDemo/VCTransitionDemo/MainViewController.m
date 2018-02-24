//
//  MainViewController.m
//  VCTransitionDemo
//
//  Created by Rannie on 2018/2/23.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "MainViewController.h"
#import "ModalViewController.h"
#import <UIKit/UIKit.h>
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "SwipeUpInteractiveTransition.h"

@interface MainViewController ()<ModalViewControllerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) BouncePresentAnimation *presentAnimation;
@property (nonatomic,strong) NormalDismissAnimation *dismissAnimation;
@property (nonatomic,strong) SwipeUpInteractiveTransition *transitionController;
@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _presentAnimation = [BouncePresentAnimation new];
        _dismissAnimation = [NormalDismissAnimation new];
        _transitionController = [SwipeUpInteractiveTransition new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *buttton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [buttton setTitle:@"Click me" forState:UIControlStateNormal];
    [buttton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttton];
}

- (void)buttonClicked:(UIButton *)sender {
    ModalViewController *mvc = [[ModalViewController alloc] init];
    mvc.delegate = self;
    mvc.transitioningDelegate = self;
    [self.transitionController wireToViewController:mvc];
    [self presentViewController:mvc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

//针对动画切换，我们需要分别在呈现VC和解散VC给出一个实现了UIViewControllerAnimatedTransitioning接口的对象（包含切换时长和如何切换）
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimation;
}

//涉及交互式切换，之后再说
//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
//
//}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transitionController.intracting ? self.transitionController : nil;
}

#pragma mark - ModalViewControllerDelegate

- (void)modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
