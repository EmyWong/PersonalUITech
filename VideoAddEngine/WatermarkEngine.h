//
//  WatermarkEngine.h
//  Five-New
//
//  Created by huyangyang on 2018/3/13.
//  Copyright © 2018年 Thel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GPUImage/GPUImage.h>
//#import <lottie-ios/Lottie/Lottie.h>
@interface WatermarkEngine : NSObject
// AVFoundation
+ (void)addWaterMarkTypeWithCorAnimationAndInputVideoURL:(NSURL*)InputURL WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler;
+ (void)addWaterMarkTypeWithLottieAndInputVideoURL:(NSURL*)InputURL WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler;
+ (void)addWaterMarkTypeWithGIFAndInputVideoURL:(NSURL*)InputURL userID:(NSString *)userID WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler;
// GPUImage
+ (void)addWaterMarkTypeWithGPUImageAndInputVideoURL:(NSURL*)InputURL AndWaterMarkVideoURL:(NSURL*)InputURL2 WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler;

+ (void)addWaterMarkTypeWithGPUImageUIElementAndInputVideoURL:(NSURL*)InputURL WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler;


///
+ (void) addWatermark:(UIView*)firstWatermark AndInputVideoURL:(NSURL*)InputURL AndOutPutTempFolder:(NSURL*)OutPutTempFolderUrl WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler;

+ (GPUImageFilterGroup*) addWatermarkWithResourcesNames:(NSArray* )resourcesNames Andframes:(NSArray*)frams AndTransform:(NSArray*)transforms AndLabelViews:(NSArray*)labelViews;
@end
