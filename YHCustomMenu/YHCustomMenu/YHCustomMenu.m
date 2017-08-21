//
//  YHCustomMenu.m
//  YHCustomMenu
//
//  Created by zhenghaoMAC on 2017/8/17.
//  Copyright © 2017年 zhenghaoMAC. All rights reserved.
//

#import "YHCustomMenu.h"
#define SCREEHEIGHT ([UIScreen mainScreen].bounds.size.height - 20)

@interface YHCustomMenu ()
//用于盛放所有自定义菜单视图的数组
@property (nonatomic,retain) NSMutableArray *allViewsArr;
//用于盛放所有颜色的数组
@property (nonatomic,retain) NSMutableArray *allColorArr;
@end
@implementation YHCustomMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (NSMutableArray *)allViewsArr {
    if (!_allViewsArr) {
        self.allViewsArr = [[NSMutableArray alloc] init];
    }
    return _allViewsArr;
}

- (NSMutableArray *)allColorArr {
    if (!_allColorArr) {
        self.allColorArr = [[NSMutableArray alloc] init];
    }
    return _allColorArr;
}
//设置数字之后才能添加 自定义菜单视图
- (void)setNumber:(NSInteger)number {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < number; i ++) {
        YHCustomMenuView *view = [[YHCustomMenuView alloc] initWithFrame:CGRectMake(0,height/number * i,width,height/number )];
        view.tag = 10000+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        [self.allViewsArr addObject:view];
    }
}
//设置图标数组后才能设置 自定义菜单视图的 图标
- (void)setIconImgArr:(NSArray *)iconImgArr {
    for (int i = 0; i < self.allViewsArr.count; i++) {
        YHCustomMenuView *view = self.allViewsArr[i];
        view.iconImg = [UIImage imageNamed:iconImgArr[i]];
    }
}
//设置主题颜色数组后才能设置 自定义菜单视图的 主题颜色
- (void)setThemeColorArr:(NSArray *)themeColorArr {
    [self.allColorArr addObjectsFromArray:themeColorArr];
    for (int i = 0; i < self.allViewsArr.count; i++) {
        YHCustomMenuView *view = self.allViewsArr[i];
        view.themeColor = themeColorArr[i];
    }
}
//设置默认选择的分页 会选中该分页 不选则无
- (void)setDefaultIndex:(NSInteger)defaultIndex {
    YHCustomMenuView *view = self.allViewsArr[defaultIndex - 1];
    [self changeCenterForView:view];
}
//添加点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    YHCustomMenuView *view = (YHCustomMenuView *)[tap view];
    [self changeCenterForView:view];
}

//icon颜色的变化以及彩色遮挡物的位置动画
- (void)changeCenterForView:(YHCustomMenuView *)customView {
    for (YHCustomMenuView *view in self.subviews) {
        NSArray *viewArr = [view subviews];
        if ([view isEqual:customView]) {
            view.userInteractionEnabled = NO;
            for (UIView *view in viewArr) {
                if (view.frame.size.width == self.frame.size.width) {
                    [UIView animateWithDuration:0.3 delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                        CGPoint center = view.center;
                        center.x += SCREEHEIGHT/7;
                        view.center = center;
                        [customView.iconImgView setTintColor:[UIColor whiteColor]];
                    } completion: nil];
                }
            }
        } else {
            view.userInteractionEnabled = YES;
            for (UIView * subview in viewArr) {
                if (subview.frame.size.width == self.frame.size.width) {
                    if (subview.frame.origin.x >= 0) {
                        [UIView animateWithDuration:0.3 delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                            CGPoint center = subview.center;
                            center.x -= SCREEHEIGHT/7;
                            subview.center = center;
                            [view.iconImgView setTintColor:self.allColorArr[(view.tag - 10000)]];
                        } completion: nil];
                    }
                }
            }
        }
    }
}
@end
