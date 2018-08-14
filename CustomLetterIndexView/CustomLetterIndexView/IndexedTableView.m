//
//  IndexedTableView.m
//  CustomLetterIndexView
//
//  Created by Emy on 2018/8/14.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "IndexedTableView.h"
#import "ViewReusePool.h"

@interface IndexedTableView ()
{
    UIView *containerView;
    ViewReusePool *reusePool;
}
@end

@implementation IndexedTableView

- (void)reloadData {
    [super reloadData];
    
    //懒加载
    if (containerView == nil) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor whiteColor];
        
        //避免索引条引table滚动
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    
    
    if (reusePool == nil) {
        reusePool = [[ViewReusePool alloc] init];
    }
    
    //标记所有视图为可重用状态
    [reusePool reset];
    
    //reload字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar {
    //获取字母索引条的现实内容
    NSArray <NSString *> *arrayTitles = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
        arrayTitles = [self.indexedDataSource indexTitlesForIndexTableView:self];
    }
    
    //判断字母索引条是否为空
    if (!arrayTitles || arrayTitles.count <= 0) {
        [containerView setHidden:YES];
        return;
    }
    
    NSUInteger count = arrayTitles.count;
    CGFloat buttonWidth = 20;
    CGFloat buttonHeight = 20;
    
    for (UIButton *btn in containerView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn removeFromSuperview];
        }
    }
    for (int i = 0; i < [arrayTitles count]; i++) {
        NSString *title = [arrayTitles objectAtIndex:i];
        
        //从重用池当中取出一个Button
        UIButton *button = (UIButton *)[reusePool dequeueReusableView];
        
        //如果没有可重用的Button重新创建一个
        if (button == nil) {
            button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectZero;
            button.backgroundColor = [UIColor whiteColor];
            
            //注册Button到重用池当中
            [reusePool addUsingView:button];
            NSLog(@"新创建了一个Button");
        } else {
            NSLog(@"Button重用了");
        }
        
        //添加Button到父视图控件
        [containerView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        
        //设置Button的坐标
        [button setFrame:CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight)];
    }
    
    [containerView setHidden:NO];
    containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, buttonWidth, buttonHeight * count);
    containerView.center = CGPointMake(self.frame.origin.x + self.frame.size.width - buttonWidth / 2., self.center.y);
    
}

@end
