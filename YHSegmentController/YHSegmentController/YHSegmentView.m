//
//  YHSegmentView.m
//  YHSegmentController
//
//  Created by 王颜华 on 16/4/18.
//  Copyright © 2016年 EmyWong. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "YHSegmentView.h"
@interface YHSegmentView()<UIScrollViewDelegate>
{
    //menu的高度
    CGFloat menuHeight;
    //menu上Button的宽度
    CGFloat menuButtonWidth;
    //menu上Button的高度
    CGFloat menuButtonHeight;
    //menu上Button的数组
    NSMutableArray *menuBtns;
    //自定义的view
    UIView *customView;
    //菜单栏Button的个数
    CGFloat count;
}
@property UIView * buttonView;
@property UIScrollView *bodyView;
@property CGFloat interval;
@property CGFloat offset;

@end

@implementation YHSegmentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {

        //设置菜单栏的高度，可修改
        menuHeight = 40;

        //设置菜单栏Button的名称，可修改
        self.titleArray = @[@"一楼", @"二楼",@"三楼",@"四楼",@"五楼",@"六楼",@"七楼",@"八楼"];
        count = self.titleArray.count;
        self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, menuHeight)];
        self.buttonView.backgroundColor = [UIColor redColor];
        self.bodyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,20 + menuHeight, ScreenWidth, ScreenHeight - self.bodyView.frame.origin.y)];
        self.bodyView.backgroundColor = [UIColor grayColor];
        
        self.bodyView.contentSize = CGSizeMake(ScreenWidth * count, self.bodyView.frame.size.height);
        self.bodyView.alwaysBounceHorizontal=YES;
        self.bodyView.bounces = YES;
        self.bodyView.pagingEnabled = YES;
        self.bodyView.scrollEnabled = YES;
        self.bodyView.delegate = self;
        self.bodyView.userInteractionEnabled = YES;
        self.bodyView.showsHorizontalScrollIndicator=NO;
        self.bodyView.showsVerticalScrollIndicator=NO;
        [self.bodyView setContentOffset:CGPointMake(0, 0)];

        
        customView = [UIView new];
        
        [self addAllSubviews];
    }
    return self;
}

- (void)addAllSubviews
{
    [self addSubview:self.buttonView];
    [self addSubview:self.bodyView];
    [self addButton];
}

- (void)addButton
{
    
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        menuButtonWidth = 42;
        menuButtonHeight = 30;
        _interval = (ScreenWidth - count * menuButtonWidth)/(count - 1);
        float menuBtnY = (menuHeight - menuButtonHeight) / 2;
      
        
        btn.frame = CGRectMake((42 + _interval) * i, menuBtnY, menuButtonWidth, menuButtonHeight);
        [btn setTitle:self.titleArray[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      
        btn.tag = i;
        
        [self.buttonView addSubview:btn];
        [menuBtns addObject:btn];
        
    }
    //设置默认显示第一页
    [self changeMenuBtnColor: 0];

}
- (void)menuBtnClick:(id)sender
{
    UIButton *btn = sender;
    
    NSInteger tag = btn.tag;
    
    [self changeMenuBtnColor:tag];
    
   // [self.bodyView scrollRectToVisible:CGRectMake(tag * WScreen, menuHeight, WScreen, bodyHeight) animated:NO];
    
    
}

-(void) changeMenuBtnColor:(NSInteger) currentPage{
    UIColor *whiteColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255
                                          alpha:1];
    for(int i = 0; i < self.titleArray.count; i++){
        
        
        UIButton *btn = menuBtns[i];
        if (i == currentPage){
         
            btn.titleLabel.textColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            customView.frame = CGRectMake((menuButtonWidth + _interval) * i,self.buttonView.frame.size.height - 2, menuButtonWidth, 2);
            customView.backgroundColor = [UIColor whiteColor];
            [self.buttonView addSubview:customView];
            
        } else {
            btn.titleLabel.textColor = whiteColor;
            [btn setTitleColor:whiteColor forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor clearColor]];
            
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    
    
    int currentPage = floor((self.bodyView.contentOffset.x - ScreenWidth/ (8)) / ScreenWidth) + 1;
    [self changeMenuBtnColor:currentPage];
    
}

@end
