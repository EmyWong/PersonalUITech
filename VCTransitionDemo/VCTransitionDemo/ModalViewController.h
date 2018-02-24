//
//  ModalViewController.h
//  VCTransitionDemo
//
//  Created by Rannie on 2018/2/23.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

- (void) modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController;

@end

@interface ModalViewController : UIViewController
@property (nonatomic,weak) id<ModalViewControllerDelegate> delegate;
@property (nonatomic,weak) id<UIViewControllerTransitioningDelegate> transitioningDelegate;
@end
