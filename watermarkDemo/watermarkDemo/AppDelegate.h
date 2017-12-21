//
//  AppDelegate.h
//  watermarkDemo
//
//  Created by Administrator on 2017/12/21.
//  Copyright © 2017年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

