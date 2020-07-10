//
//  BlockViewController.h
//  BlockDemo
//
//  Created by Emy on 2020/6/18.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockViewController : UIViewController

@property (nonatomic, strong) void(^blockTest)(NSString *result);

@end

NS_ASSUME_NONNULL_END
