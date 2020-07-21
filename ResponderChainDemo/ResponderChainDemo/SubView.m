//
//  SubView.m
//  ResponderChainDemo
//
//  Created by Emy on 2020/7/21.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "SubView.h"

@implementation SubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"传到这里来了%s",__FUNCTION__);
    NSLog(@"%@",[NSThread callStackSymbols]);
}

@end
