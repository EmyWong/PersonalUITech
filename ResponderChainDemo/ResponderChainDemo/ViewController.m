//
//  ViewController.m
//  ResponderChainDemo
//
//  Created by Emy on 2020/7/16.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
#import "EnlageButtonView.h"
#import "UIButton+EventInterval.h"
#import "UIButton+ClickAction.h"
#import "SuperView.h"
#import "SubView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self enlargeButtonMethod1];
    [self enlargeButtonMethod2];
//    [self testReponderChain];

}

// 扩大Button点击范围
- (void)enlargeButtonMethod1 {
    /**
     方法一：通过重写UIView的方法hitTest:withEvent:方法修改响应范围，在指定范围内响应UIButton的点击事件，该方法不够简洁。
     */
    EnlageButtonView *subview = [[EnlageButtonView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    subview.backgroundColor = [UIColor grayColor];
    subview.center = self.view.center;
    [self.view addSubview:subview];
    NSLog(@"%@",[subview parentController]);
}

- (void)enlargeButtonMethod2 {
    /**
     方法二：通过增加UIButton的Category来重写hitTest:withEvent:方法修改响应范围。
     */
    /**
     在UIButton的类目里增加了显示范围为上下左右各增加50像素，即将button的frame size由（20，20）变成了（120，120）,enlargeShowView是为了更清晰的显示出button被扩大的范围而添加的。
     实际上并不需要该视图。
     */
    UIView *enlargeShowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    enlargeShowView.backgroundColor = [UIColor lightGrayColor];
    enlargeShowView.center = self.view.center;
    [self.view addSubview:enlargeShowView];

    UIButton *enlargeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    enlargeButton.frame = CGRectMake(0, 0, 20, 20);
    enlargeButton.center = self.view.center;
    enlargeButton.backgroundColor = [UIColor redColor];
    [enlargeButton setTitle:@"E" forState:UIControlStateNormal];
    enlargeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [enlargeButton addTarget:self action:@selector(enlargeAction:) forControlEvents:UIControlEventTouchUpInside];
    enlargeButton.eventInterval = 2.0;
    [self.view addSubview:enlargeButton];
}

- (void)enlargeAction:(UIButton *)sender {
    //控制按钮响应时间，例如”防暴力点击“的方法 https://www.jianshu.com/p/c2243ac4f620
    /**
     方案 1：通过UIButton的enabled属性和userInteractionEnabled属性控制按钮是否可点击。此方案在逻辑上比较清晰、易懂，但具体代码书写分散，常常涉及多个方法。
     */
//    sender.enabled = NO;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        sender.enabled = YES;
//    });
    /**
     方案2：通过NSObject的+cancelPreviousPerformRequestsWithTarget:selector:object:方法和-performSelector:withObject:afterDelay:方法控制按钮的响应事件的执行时间间隔。此方案会在连续点击按钮时取消之前的点击事件，从而只执行最后一次点击事件，会出现延迟现象。
     */
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(enlargeAction:) object:sender];
//    [sender performSelector:@selector(enlargeAction:) withObject:sender afterDelay:2.0];
    
    //在需要对大量UIButton做控制的场景中，方案1和方案2会比较不方便。针对此场景，着重说一下方案3。
    /**
     方案3：通过Runtime控制UIButton响应事件的时间间隔。思路如下：
     1、创建一个UIButton的类别，使用runtime为UIButton增加public属性eventInterval和private属性eventUnavailable。
     2、在+load方法中使用runtime将UIButton的-sendAction:to:forEvent:方法与自定义的-hook_sendAction:to:forEvent:方法交换Implementation。
     3、使用eventInterval作为控制eventUnavailable的计时因子，用eventUnavailable开控制UIButton的event事件是否有效。
    B
     详细见UIButton + EventInterval.m
     测试方法：疯狂点击Button看控制台输出时间间隔，并不会重复执行Button的点击事件，而是在指定时间后执行。
     */
    NSLog(@"enlageButton:%s",__FUNCTION__);
}

- (void)testReponderChain {
    SuperView *superView = [[SuperView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    superView.backgroundColor = [UIColor redColor];
    superView.center = self.view.center;
    [self.view addSubview:superView];
    
    SubView *subView = [[SubView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    subView.backgroundColor = [UIColor yellowColor];
    [superView addSubview:subView];
  
    /**
     点击事件默认是执行SubView的touches方法，解开subView.userInteractionEnabled = NO;之后执行SuperView的touches方法，再解开superView.userInteractionEnabled = NO;之后执行UIViewController的touches方法，再解开self.view.userInteractionEnabled = NO;之后执行AppDelegate也就是UIApplication的touches方法。虽然因为手动输出显示不准确，但也可以大体上理解响应者链的响应顺序了。
     */
//    subView.userInteractionEnabled = NO;
//    superView.userInteractionEnabled = NO;
//    self.view.userInteractionEnabled = NO;
}
/**
 该方法是为了测试touches方法子控件中调用父类方法的效果，需要将注释解开
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /**
     测试响应链条
     */
    //    UIResponder *res = self.view;
    //    while (res) {
    //        NSLog(@"****************TOUCHES***************\n%@",res);
    //        res = [res nextResponder];
    //    }
   
    /**
    该方法是为了测试touches方法子控件中调用父类方法的效果，需要将注释解开
    */
//    SubViewController *vc = [[SubViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    NSLog(@"传到这里来了%s",__FUNCTION__);
}

@end
