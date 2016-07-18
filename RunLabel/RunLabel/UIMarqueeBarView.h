//
//  UIMarqueeBarView.h
//  RunLabel
//
//  Created by 王颜华 on 16/7/18.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMarqueeBarView : UIView

@property (nonatomic,retain) UIView *viewContainer;
- (void)start;

- (void)stop;
@end
