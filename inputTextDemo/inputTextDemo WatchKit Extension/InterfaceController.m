//
//  InterfaceController.m
//  inputTextDemo WatchKit Extension
//
//  Created by Emy on 2018/6/14.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *label;

@end


@implementation InterfaceController

- (IBAction)tapAction:(id)sender {
    [self inputAction];
}

//弹出输入框
- (void)inputAction {
    NSArray *array = @[@"こんにちは", @"はい、なんでしょう？", @"今、向かつて"];
    [self presentTextInputControllerWithSuggestions:array allowedInputMode:WKTextInputModeAllowEmoji completion:^(NSArray * _Nullable results) {
        if (results && results.count != 0) {
            [self.label setText:results.firstObject];
        } else {
            NSLog(@"ERROR");
        }
        
    }];
}
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



