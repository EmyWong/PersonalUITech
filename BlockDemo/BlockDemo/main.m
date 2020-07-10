//
//  main.m
//  BlockDemo
//
//  Created by Emy on 2020/6/18.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        //Block Example
        void (^block)(void) = ^{
            NSLog(@"Hello World!");
        };
        
        block();
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
