//
//  WatermarkEngine.m
//  Five-New
//
//  Created by huyangyang on 2018/3/13.
//  Copyright © 2018年 Thel. All rights reserved.
//

#import "WatermarkEngine.h"
@implementation WatermarkEngine

#pragma mark CorAnimation
+ (void)addWaterMarkTypeWithCorAnimationAndInputVideoURL:(NSURL*)InputURL WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(YES) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVAsset *videoAsset = [AVURLAsset URLAssetWithURL:InputURL options:opts];
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    NSError *errorVideo = [NSError new];
    AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
    CMTime endTime = assetVideoTrack.asset.duration;
    BOOL bl = [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetVideoTrack.asset.duration)
                                  ofTrack:assetVideoTrack
                                   atTime:kCMTimeZero error:&errorVideo];
    videoTrack.preferredTransform = assetVideoTrack.preferredTransform;
    NSLog(@"errorVideo:%ld%d",errorVideo.code,bl);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *outPutFileName = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",outPutFileName]];
    NSURL* outPutVideoUrl = [NSURL fileURLWithPath:myPathDocs];
    
    CGSize videoSize = [videoTrack naturalSize];
    
    UIFont *font = [UIFont systemFontOfSize:60.0];
    CATextLayer *aLayer = [[CATextLayer alloc] init];
    [aLayer setFontSize:60];
    [aLayer setString:@"H"];
    [aLayer setAlignmentMode:kCAAlignmentCenter];
    [aLayer setForegroundColor:[[UIColor greenColor] CGColor]];
    [aLayer setBackgroundColor:[UIColor clearColor].CGColor];
    CGSize textSize = [@"H" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    [aLayer setFrame:CGRectMake(240, 470, textSize.width, textSize.height)];
    aLayer.anchorPoint = CGPointMake(0.5, 1.0);

    
    CATextLayer *bLayer = [[CATextLayer alloc] init];
    [bLayer setFontSize:60];
    [bLayer setString:@"E"];
    [bLayer setAlignmentMode:kCAAlignmentCenter];
    [bLayer setForegroundColor:[[UIColor greenColor] CGColor]];
    [bLayer setBackgroundColor:[UIColor clearColor].CGColor];
    CGSize textSizeb = [@"E" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    [bLayer setFrame:CGRectMake(240 + textSize.width, 470 , textSizeb.width, textSizeb.height)];
    bLayer.anchorPoint = CGPointMake(0.5, 1.0);

    
    CATextLayer *cLayer = [[CATextLayer alloc] init];
    [cLayer setFontSize:60];
    [cLayer setString:@"L"];
    [cLayer setAlignmentMode:kCAAlignmentCenter];
    [cLayer setForegroundColor:[[UIColor greenColor] CGColor]];
    [cLayer setBackgroundColor:[UIColor clearColor].CGColor];
    CGSize textSizec = [@"L" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    [cLayer setFrame:CGRectMake(240 + textSizeb.width + textSize.width, 470 , textSizec.width, textSizec.height)];
    cLayer.anchorPoint = CGPointMake(0.5, 1.0);

    
    CATextLayer *dLayer = [[CATextLayer alloc] init];
    [dLayer setFontSize:60];
    [dLayer setString:@"L"];
    [dLayer setAlignmentMode:kCAAlignmentCenter];
    [dLayer setForegroundColor:[[UIColor greenColor] CGColor]];
    [dLayer setBackgroundColor:[UIColor clearColor].CGColor];
    CGSize textSized = [@"L" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    [dLayer setFrame:CGRectMake(240 + textSizec.width+ textSizeb.width + textSize.width, 470 , textSized.width, textSized.height)];
    dLayer.anchorPoint = CGPointMake(0.5, 1.0);
    
    CATextLayer *eLayer = [[CATextLayer alloc] init];
    [eLayer setFontSize:60];
    [eLayer setString:@"O"];
    [eLayer setAlignmentMode:kCAAlignmentCenter];
    [eLayer setForegroundColor:[[UIColor greenColor] CGColor]];
    [eLayer setBackgroundColor:[UIColor clearColor].CGColor];
    CGSize textSizede = [@"O" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    [eLayer setFrame:CGRectMake(240 + textSized.width + textSizec.width+ textSizeb.width + textSize.width, 470 , textSizede.width, textSizede.height)];
    eLayer.anchorPoint = CGPointMake(0.5, 1.0);

    CABasicAnimation* basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAni.fromValue = @(0.2f);
    basicAni.toValue = @(1.0f);
    basicAni.beginTime = AVCoreAnimationBeginTimeAtZero;
    basicAni.duration = 2.0f;
    basicAni.repeatCount = HUGE_VALF;
    basicAni.removedOnCompletion = NO;
    basicAni.fillMode = kCAFillModeForwards;
    [aLayer addAnimation:basicAni forKey:nil];
    [bLayer addAnimation:basicAni forKey:nil];
    [cLayer addAnimation:basicAni forKey:nil];
    [dLayer addAnimation:basicAni forKey:nil];
    [eLayer addAnimation:basicAni forKey:nil];
    
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    videoLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:aLayer];
    [parentLayer addSublayer:bLayer];
    [parentLayer addSublayer:cLayer];
    [parentLayer addSublayer:dLayer];
    [parentLayer addSublayer:eLayer];

    AVMutableVideoComposition* videoComp = [AVMutableVideoComposition videoComposition];
    videoComp.renderSize = videoSize;
    parentLayer.geometryFlipped = true;
    videoComp.frameDuration = CMTimeMake(1, 30);
    videoComp.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    AVMutableVideoCompositionInstruction* instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    
    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, endTime);
    AVMutableVideoCompositionLayerInstruction* layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    instruction.layerInstructions = [NSArray arrayWithObjects:layerInstruction, nil];
    videoComp.instructions = [NSArray arrayWithObject: instruction];
    
    
    AVAssetExportSession* exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=outPutVideoUrl;
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    exporter.videoComposition = videoComp;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //这里是输出视频之后的操作，做你想做的
            NSLog(@"输出视频地址:%@ andCode:%@",myPathDocs,exporter.error);
            handler(outPutVideoUrl,(int)exporter.error.code);
        });
    }];
}

#pragma mark Lottie
//+ (void)addWaterMarkTypeWithLottieAndInputVideoURL:(NSURL*)InputURL WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler{
//    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(YES) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
//    AVAsset *videoAsset = [AVURLAsset URLAssetWithURL:InputURL options:opts];
//    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
//    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
//                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
//    NSError *errorVideo = [NSError new];
//    AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
//    CMTime endTime = assetVideoTrack.asset.duration;
//    BOOL bl = [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetVideoTrack.asset.duration)
//                                  ofTrack:assetVideoTrack
//                                   atTime:kCMTimeZero error:&errorVideo];
//    videoTrack.preferredTransform = assetVideoTrack.preferredTransform;
//    NSLog(@"errorVideo:%ld%d",errorVideo.code,bl);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyyMMddHHmmss";
//    NSString *outPutFileName = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
//    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",outPutFileName]];
//    NSURL* outPutVideoUrl = [NSURL fileURLWithPath:myPathDocs];
//    
//    CGSize videoSize = [videoTrack naturalSize];
//    
//    LOTAnimationView* animation = [LOTAnimationView animationNamed:@"青蛙"];
//    animation.frame = CGRectMake(150 , 340 , 240 , 240 );
//    animation.animationSpeed = 5.0 ;
//    animation.loopAnimation = YES;
//    [animation play];
//    
//    CALayer *parentLayer = [CALayer layer];
//    CALayer *videoLayer = [CALayer layer];
//    parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
//    videoLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
//    [parentLayer addSublayer:videoLayer];
//    [parentLayer addSublayer:animation.layer];
//
//    
//    AVMutableVideoComposition* videoComp = [AVMutableVideoComposition videoComposition];
//    videoComp.renderSize = videoSize;
//    parentLayer.geometryFlipped = true;
//    videoComp.frameDuration = CMTimeMake(1, 30);
//    videoComp.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
//    AVMutableVideoCompositionInstruction* instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
//    
//    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, endTime);
//    AVMutableVideoCompositionLayerInstruction* layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
//    instruction.layerInstructions = [NSArray arrayWithObjects:layerInstruction, nil];
//    videoComp.instructions = [NSArray arrayWithObject: instruction];
//    
//    
//    AVAssetExportSession* exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
//                                                                      presetName:AVAssetExportPresetHighestQuality];
//    exporter.outputURL=outPutVideoUrl;
//    exporter.outputFileType = AVFileTypeMPEG4;
//    exporter.shouldOptimizeForNetworkUse = YES;
//    exporter.videoComposition = videoComp;
//    [exporter exportAsynchronouslyWithCompletionHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //这里是输出视频之后的操作，做你想做的
//            NSLog(@"输出视频地址:%@ andCode:%@",myPathDocs,exporter.error);
//            handler(outPutVideoUrl,(int)exporter.error.code);
//        });
//    }];
//}

#pragma mark GIF
+ (void)addWaterMarkTypeWithGIFAndInputVideoURL:(NSURL*)InputURL userID:(NSString *)userID WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler{
    
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(YES) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVAsset *videoAsset = [AVURLAsset URLAssetWithURL:InputURL options:opts];
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    NSError *errorVideo = [NSError new];
    AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
    CMTime endTime = assetVideoTrack.asset.duration;
    BOOL bl = [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetVideoTrack.asset.duration)
                                  ofTrack:assetVideoTrack
                                   atTime:kCMTimeZero error:&errorVideo];
    videoTrack.preferredTransform = assetVideoTrack.preferredTransform;
    NSLog(@"errorVideo:%ld%d",errorVideo.code,bl);
    
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    NSError *errorAudio = [NSError new];
    AVAssetTrack *assetsAudioTrack = [videoAsset tracksWithMediaType:AVMediaTypeAudio].firstObject;
    BOOL ba = [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetsAudioTrack.asset.duration) ofTrack:assetsAudioTrack atTime:kCMTimeZero error:&errorAudio];
    NSLog(@"errorAudio:%ld%d",errorAudio.code,ba);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *outPutFileName = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",outPutFileName]];
    NSURL* outPutVideoUrl = [NSURL fileURLWithPath:myPathDocs];
    
    CGSize videoSize = [videoTrack naturalSize];
    
//    CALayer *gifLayer1 = [[CALayer alloc] init];
//    gifLayer1.frame = CGRectMake(videoSize.width - 298 , videoSize.height - 253 - 50, 298 , 253 );
//    CAKeyframeAnimation *gifLayer1Animation = [WatermarkEngine animationForGifWithURL:[[NSBundle mainBundle] URLForResource:@"雪人完成_1" withExtension:@"gif"]];
//    gifLayer1Animation.beginTime = AVCoreAnimationBeginTimeAtZero;
//    gifLayer1Animation.removedOnCompletion = NO;
//    [gifLayer1 addAnimation:gifLayer1Animation forKey:@"gif"];
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.frame = CGRectMake(videoSize.width - 308, videoSize.height - 100, 298, 100);
    textLayer.string = [NSString stringWithFormat:@"好主播\nID:%@",userID];
    textLayer.fontSize = 30;
    textLayer.alignmentMode = @"right";
    
    
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    videoLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    [parentLayer addSublayer:videoLayer];
//    [parentLayer addSublayer:gifLayer1];
    [parentLayer addSublayer:textLayer];
    
    AVMutableVideoComposition* videoComp = [AVMutableVideoComposition videoComposition];
    videoComp.renderSize = videoSize;
    parentLayer.geometryFlipped = true;
    videoComp.frameDuration = CMTimeMake(1, 30);
    videoComp.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    AVMutableVideoCompositionInstruction* instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    
    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, endTime);
    AVMutableVideoCompositionLayerInstruction* layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    instruction.layerInstructions = [NSArray arrayWithObjects:layerInstruction, nil];
    videoComp.instructions = [NSArray arrayWithObject: instruction];
    
    
    AVAssetExportSession* exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=outPutVideoUrl;
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    exporter.videoComposition = videoComp;

    
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //这里是输出视频之后的操作，做你想做的
            NSLog(@"输出视频地址:%@ andCode:%@",myPathDocs,exporter.error);
            handler(outPutVideoUrl,(int)exporter.error.code);
        });
    }];
}

#pragma mark GPUImage TWO VIDEO INPUT
+ (void)addWaterMarkTypeWithGPUImageAndInputVideoURL:(NSURL*)InputURL AndWaterMarkVideoURL:(NSURL*)InputURL2 WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *outPutFileName = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",outPutFileName]];
    NSURL* outPutVideoUrl = [NSURL fileURLWithPath:myPathDocs];
    
    GPUImageMovie* movieFile = [[GPUImageMovie alloc] initWithURL:InputURL];
    GPUImageMovie* movieFile2 = [[GPUImageMovie alloc] initWithURL:InputURL2];
    GPUImageScreenBlendFilter* filter =  [[GPUImageScreenBlendFilter alloc] init];
    [movieFile addTarget:filter];
    [movieFile2 addTarget:filter];
    
    GPUImageMovieWriter* movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:outPutVideoUrl size:CGSizeMake(540, 960) fileType:AVFileTypeQuickTimeMovie outputSettings:    @
                                        {
                                        AVVideoCodecKey: AVVideoCodecH264,
                                        AVVideoWidthKey: @540,   //Set your resolution width here
                                        AVVideoHeightKey: @960,  //set your resolution height here
                                        AVVideoCompressionPropertiesKey: @
                                            {
                                                //2000*1000  建议800*1000-5000*1000
                                                //AVVideoAverageBitRateKey: @2500000, // Give your bitrate here for lower size give low values
                                            AVVideoAverageBitRateKey: @5000000,
                                            AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
                                            AVVideoAverageNonDroppableFrameRateKey: @30,
                                            },
                                        }
                                        ];
    [filter  addTarget:movieWriter];
    AVAsset* videoAsset = [AVAsset assetWithURL:InputURL];
    AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
    movieWriter.transform = assetVideoTrack.preferredTransform;
    //    [movie enableSynchronizedEncodingUsingMovieWriter:movieWriter];
    [movieWriter startRecording];
    [movieFile startProcessing];
    [movieFile2 startProcessing];
    [movieWriter setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"movieWriter Completion");
            
            handler(outPutVideoUrl,1);
        });

    }];
    
}

#pragma mark GPUImageUIElement
+ (void)addWaterMarkTypeWithGPUImageUIElementAndInputVideoURL:(NSURL*)InputURL WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *outPutFileName = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",outPutFileName]];
    NSURL* outPutVideoUrl = [NSURL fileURLWithPath:myPathDocs];
    
    GPUImageMovie* movieFile = [[GPUImageMovie alloc] initWithURL:InputURL];

    

    NSValue *value = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - (332 /2.0) , [UIScreen mainScreen].bounds.size.height/2.0 - (297 /2.0) , 332 , 297 )];
    NSValue *value2 = [NSValue valueWithCGAffineTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    GPUImageFilterGroup* filter =  [WatermarkEngine addWatermarkWithResourcesNames:@[@"雨天青蛙"] Andframes:@[value] AndTransform:@[value2] AndLabelViews:@[view]];
    [movieFile addTarget:filter];

    
    GPUImageMovieWriter* movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:outPutVideoUrl size:CGSizeMake(540, 960) fileType:AVFileTypeQuickTimeMovie outputSettings:    @
                                        {
                                        AVVideoCodecKey: AVVideoCodecH264,
                                        AVVideoWidthKey: @540,   //Set your resolution width here
                                        AVVideoHeightKey: @960,  //set your resolution height here
                                        AVVideoCompressionPropertiesKey: @
                                            {
                                                //2000*1000  建议800*1000-5000*1000
                                                //AVVideoAverageBitRateKey: @2500000, // Give your bitrate here for lower size give low values
                                            AVVideoAverageBitRateKey: @5000000,
                                            AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
                                            AVVideoAverageNonDroppableFrameRateKey: @30,
                                            },
                                        }
                                        ];
    [filter  addTarget:movieWriter];
    AVAsset* videoAsset = [AVAsset assetWithURL:InputURL];
    AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
    movieWriter.transform = assetVideoTrack.preferredTransform;
    //    [movie enableSynchronizedEncodingUsingMovieWriter:movieWriter];
    [movieWriter startRecording];
    [movieFile startProcessing];
    [movieWriter setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"movieWriter Completion");
            
            handler(outPutVideoUrl,1);
        });
        
    }];
}


+ (void) addWatermark:(UIView*)firstWatermark AndInputVideoURL:(NSURL*)InputURL AndOutPutTempFolder:(NSURL*)OutPutTempFolderUrl WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler{
  NSDictionary *opts = [NSDictionary dictionaryWithObject:@(YES) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
  AVAsset *videoAsset = [AVURLAsset URLAssetWithURL:InputURL options:opts];
  AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
  AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                      preferredTrackID:kCMPersistentTrackID_Invalid];
  AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                      preferredTrackID:kCMPersistentTrackID_Invalid];
  NSError *errorVideo = [NSError new];
  AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
  CMTime endTime = assetVideoTrack.asset.duration;
  BOOL bl = [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetVideoTrack.asset.duration)
                                ofTrack:assetVideoTrack
                                 atTime:kCMTimeZero error:&errorVideo];
  NSLog(@"errorVideo:%@%d",errorVideo,bl);
  NSError *erroraudio = [NSError new];
  AVAssetTrack *assetAudioTrack = [[videoAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
  BOOL ba = [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, endTime)
                                ofTrack:assetAudioTrack
                                 atTime:kCMTimeZero
                                  error:&erroraudio];
  NSLog(@"erroraudio:%@%d",erroraudio,ba);
  CGAffineTransform t = assetVideoTrack.preferredTransform;
  videoTrack.preferredTransform = t;
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  
  NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",@"waterTemp"]];
//  let destFile = tempFolder.appendingPathComponent("Merged.mp4")
//  NSURL* outPutTempVideoUrl = [NSURL fileURLWithPath:myPathDocs];
  NSURL* outPutTempVideoUrl = [OutPutTempFolderUrl URLByAppendingPathComponent:@"waterTemp.mp4"];
  CGSize videoSize = CGSizeMake(960, 540);
  CALayer *parentLayer = [CALayer layer];
  CALayer *videoLayer = [CALayer layer];
  parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
  videoLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
  [parentLayer addSublayer:videoLayer];
  CALayer *tipLayer = [CALayer layer];
  tipLayer.frame = CGRectMake(0, 0, 960, 960);
  [parentLayer addSublayer:tipLayer];
  tipLayer.anchorPoint = CGPointMake(0.5, 0.5);
  tipLayer.affineTransform = CGAffineTransformRotate(tipLayer.affineTransform, -M_PI_2);
  tipLayer.affineTransform = CGAffineTransformTranslate(tipLayer.affineTransform, 420, 0);
  
  
  float scale = 540.0/[UIScreen mainScreen].bounds.size.width;
  firstWatermark.layer.frame = CGRectMake(firstWatermark.layer.frame.origin.x * scale, firstWatermark.layer.frame.origin.y * scale, firstWatermark.layer.frame.size.width * scale, firstWatermark.layer.frame.size.height * scale);
  
  [tipLayer addSublayer:firstWatermark.layer];
  
  AVMutableVideoComposition* videoComp = [AVMutableVideoComposition videoComposition];
  videoComp.renderSize = CGSizeMake(960, 540);
  parentLayer.geometryFlipped = true;
  videoComp.frameDuration = CMTimeMake(1, 30);
  videoComp.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
  AVMutableVideoCompositionInstruction* instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
  
  instruction.timeRange = CMTimeRangeMake(kCMTimeZero, endTime);
  AVMutableVideoCompositionLayerInstruction* layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
  instruction.layerInstructions = [NSArray arrayWithObjects:layerInstruction, nil];
  videoComp.instructions = [NSArray arrayWithObject: instruction];

  AVAssetExportSession* exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                    presetName:AVAssetExportPresetHighestQuality];
  exporter.outputURL=outPutTempVideoUrl;
  exporter.outputFileType = AVFileTypeMPEG4;
  exporter.shouldOptimizeForNetworkUse = YES;
  exporter.videoComposition = videoComp;
  [exporter exportAsynchronouslyWithCompletionHandler:^{
    dispatch_async(dispatch_get_main_queue(), ^{
      //这里是输出视频之后的操作，做你想做的
//      NSLog(@"输出视频地址:%@ andCode:%@",myPathDocs,exporter.error);
      
      NSDictionary *opts = [NSDictionary dictionaryWithObject:@(YES) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
      AVAsset *videoAsset = [AVURLAsset URLAssetWithURL:outPutTempVideoUrl options:opts];     //初始化视频媒体文件
      
      AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
      
      AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                          preferredTrackID:kCMPersistentTrackID_Invalid];
      AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                          preferredTrackID:kCMPersistentTrackID_Invalid];
      
      NSError *errorVideo = [NSError new];
      //把视频轨道数据加入到可变轨道中 这部分可以做视频裁剪TimeRange
      AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
      CMTime endTime = assetVideoTrack.asset.duration;
      BOOL bl = [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetVideoTrack.asset.duration)
                                    ofTrack:assetVideoTrack
                                     atTime:kCMTimeZero error:&errorVideo];
      NSLog(@"errorVideo:%@%d",errorVideo,bl);
      NSError *erroraudio = [NSError new];
      AVAssetTrack *assetAudioTrack = [[videoAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
      BOOL ba = [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, endTime)
                                    ofTrack:assetAudioTrack
                                     atTime:kCMTimeZero
                                      error:&erroraudio];
      NSLog(@"erroraudio:%@%d",erroraudio,ba);
      
      CGAffineTransform t = videoTrack.preferredTransform;
      t.a = 0.0;
      t.b = 1.0;
      t.c = -1.0;
      t.d = 0.0;
      videoTrack.preferredTransform = t;
      
      AVAssetExportSession* exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                        presetName:AVAssetExportPresetPassthrough];
      NSURL* outPutURL = [OutPutTempFolderUrl URLByAppendingPathComponent:@"water.mp4"];
      exporter.outputURL=outPutURL;
      exporter.outputFileType = AVFileTypeMPEG4;
      exporter.shouldOptimizeForNetworkUse = YES;
      [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{

          handler(outPutURL,(int)exporter.error.code);
        });
      }];
      
    });
  }];

}

+ (GPUImageFilterGroup*) addWatermarkWithResourcesNames:(NSArray* )resourcesNames Andframes:(NSArray*)frams AndTransform:(NSArray*)transforms AndLabelViews:(NSArray*)labelViews{
  __block int currentPicIndex = 0;
  CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
  UIView* temp = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [temp setContentScaleFactor:[[UIScreen mainScreen] scale]];
  __block UIImageView* waterImageView1 = [[UIImageView alloc] init];
  __block UIImageView* waterImageView2 = [[UIImageView alloc] init];
  __block UIImageView* waterImageView3 = [[UIImageView alloc] init];
  for (int index = 0 ; index < resourcesNames.count ; index++) {
    if (index == 0) {
      waterImageView1.frame = [frams[index] CGRectValue];
      UIImage* tempImage = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%05d",resourcesNames[index],currentPicIndex] ofType:@"png"]];
      waterImageView1.image = tempImage;
      waterImageView1.transform = [transforms[index] CGAffineTransformValue];
      [temp addSubview:waterImageView1];
      [temp addSubview:labelViews[index]];
    }else if (index == 1){
      waterImageView2.frame = [frams[index] CGRectValue];
      UIImage* tempImage = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%05d",resourcesNames[index],currentPicIndex] ofType:@"png"]];
      waterImageView2.image = tempImage;
      waterImageView2.transform = [transforms[index] CGAffineTransformValue];
      [temp addSubview:waterImageView2];
      [temp addSubview:labelViews[index]];
    }else{
      waterImageView3.frame = [frams[index] CGRectValue];
      UIImage* tempImage = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%05d",resourcesNames[index],currentPicIndex] ofType:@"png"]];
      waterImageView3.image = tempImage;
      waterImageView3.transform = [transforms[index] CGAffineTransformValue];
      [temp addSubview:waterImageView3];
      [temp addSubview:labelViews[index]];
    }
    

  }
  
  
  

  
   GPUImageFilterGroup* filterGroup = [[GPUImageFilterGroup alloc] init];
  
  GPUImageUIElement *uiElement = [[GPUImageUIElement alloc] initWithView:temp];
  GPUImageTwoInputFilter* blendFilter = [[GPUImageTwoInputFilter alloc] initWithFragmentShaderFromString:[WatermarkEngine loadShader:@"AlphaBlend_Normal" extension:@"frag"]];
  GPUImageFilter* filter = [[GPUImageFilter alloc] init];

  GPUImageFilter* uiFilter = [[GPUImageFilter alloc] init];
  [uiElement addTarget:uiFilter];
//  [uiFilter setInputRotation:kGPUImageRotateLeft atIndex:0];
  
  [filter addTarget:blendFilter];
  [uiFilter addTarget:blendFilter];
  
  
  [filterGroup addFilter:filter];
  [filterGroup addFilter:uiFilter];
  [filterGroup addFilter:blendFilter];

  
  [filterGroup setInitialFilters:@[filter]];
  [filterGroup setTerminalFilter:blendFilter];
  // 71
  //    __unsafe_unretained typeof(self) this = self;
  [filter setFrameProcessingCompletionBlock:^(GPUImageOutput * filter, CMTime frameTime) {
    currentPicIndex += 1;
    
    for (int index = 0 ; index < resourcesNames.count ; index++) {
      if (index == 0) {
        waterImageView1.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%05d",resourcesNames[index],currentPicIndex] ofType:@"png"]];
      }else if (index == 1){
        waterImageView2.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%05d",resourcesNames[index],currentPicIndex] ofType:@"png"]];
      }else{
        waterImageView3.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%05d",resourcesNames[index],currentPicIndex] ofType:@"png"]];
      }
      
      
    }
    
    
    if (currentPicIndex == 89) {
      currentPicIndex = 0;
    }
    
    [uiElement update];
  }];
  
  return filterGroup;
  
}

+ (NSString * _Nonnull)loadShader:(NSString *)name extension:(NSString *)extenstion {
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:extenstion];
    return [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
}

+ (CAKeyframeAnimation *)animationForGifWithURL:(NSURL *)url {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    
    NSMutableArray * frames = [NSMutableArray new];
    NSMutableArray *delayTimes = [NSMutableArray new];
    
    CGFloat totalTime = 0.0;
    CGFloat gifWidth;
    CGFloat gifHeight;
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    
    // get frame count
    size_t frameCount = CGImageSourceGetCount(gifSource);
    for (size_t i = 0; i < frameCount; ++i) {
        // get each frame
        CGImageRef frame = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [frames addObject:(__bridge id)frame];
        CGImageRelease(frame);
        
        // get gif info with each frame
        NSDictionary *dict = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL));
        NSLog(@"kCGImagePropertyGIFDictionary %@", [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary]);
        
        // get gif size
        gifWidth = [[dict valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
        gifHeight = [[dict valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        
        // kCGImagePropertyGIFDictionary中kCGImagePropertyGIFDelayTime，kCGImagePropertyGIFUnclampedDelayTime值是一样的
        NSDictionary *gifDict = [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        [delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFUnclampedDelayTime]];
        
        totalTime = totalTime + [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFUnclampedDelayTime] floatValue];
        
        //        CFRelease((__bridge CFTypeRef)(dict));
        //        CFRelease((__bridge CFTypeRef)(dict));
    }
    if (gifSource) {
        CFRelease(gifSource);
    }
    
    NSMutableArray *times = [NSMutableArray arrayWithCapacity:3];
    CGFloat currentTime = 0;
    NSInteger count = delayTimes.count;
    for (int i = 0; i < count; ++i) {
        [times addObject:[NSNumber numberWithFloat:(currentTime / totalTime)]];
        currentTime += [[delayTimes objectAtIndex:i] floatValue];
    }
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < count; ++i) {
        [images addObject:[frames objectAtIndex:i]];
    }
    
    animation.keyTimes = times;
    animation.values = images;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = totalTime;
    animation.repeatCount = HUGE_VALF;
    
    return animation;
}
@end
