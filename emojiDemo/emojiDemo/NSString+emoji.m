//
//  NSString+emoji.m
//  emojiDemo
//
//  Created by Emy on 2018/9/8.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "NSString+emoji.h"

@implementation NSString (emoji)

- (NSString *)emojiEncode{
    NSString *uniStr = [NSString stringWithUTF8String:[self UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *emojiText = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding];
    return emojiText;
}

- (NSString *)emojiDecode{
    const char *jsonString = [self UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *emojiText = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    return emojiText;
}

@end
