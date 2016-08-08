//
//  UIColor+NotRGB.h
//  UIColor16
//
//  Created by 王颜华 on 16/8/8.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NotRGB)
+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

/**
 *  16进制转uicolor
 *
 *  @param color @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
 *
 *  @return uicolor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
@end
