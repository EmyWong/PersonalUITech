//
//  AppDelegate.h
//  VCTransitionDemo
//
//  Created by Rannie on 2018/2/22.
//  Copyright © 2018 Emy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

