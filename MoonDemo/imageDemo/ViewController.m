//
//  ViewController.m
//  imageDemo
//
//  Created by Emy on 2018/6/22.
//  Copyright © 2018年 Mobile Interactive LLC. All rights reserved.
//

#import "ViewController.h"

double toRadians(double degrees){
    return degrees * M_PI / 180.0;
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    UIImage *image2 = [self drawMoonWithImageView:imageView Angle:70. ShadeColor:[UIColor colorWithRed:77/255. green:77/255. blue:77/255. alpha:1.] moonColor:[UIColor colorWithRed:140. / 255.0 green:172. / 255.0 blue:219. / 255.0 alpha:1.0]];
    imageView.image = image2;
    
}

- (UIImage *)drawMoonWithImageView:(UIImageView *)imageView Angle:(double)angle ShadeColor:(UIColor *)shadeColor moonColor:(UIColor*)moonColor {
    float w = imageView.frame.size.width;
    float h = imageView.frame.size.height;
    
    float radius = w / 2.;
    float cx = w / 2.;
    float cy = h / 2.;
    float r = (float) (radius * fabs(cos(toRadians(angle))));
    
    CGRect rect = CGRectMake(0, 0, w, h);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), moonColor.CGColor);
    CGContextAddArc(context, cx, cy, radius, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetFillColorWithColor(context, shadeColor.CGColor);
    
    float start = (angle >= 0 && angle <= 180) ? 90 : 270;
    if (((start == 90 && angle > 90) || (start == 270 && angle <= 270))) {                                        // 凸出的月
        if (start == 270) {
            CGContextAddArc(context, cx, cy, radius, (CGFloat) toRadians(90), (CGFloat) toRadians(270), true);
            CGContextClosePath(context);
            CGContextFillPath(context);
            
            CGContextSaveGState(context);
            CGRect clipRect = CGRectMake(cx - r, cy - radius, r, radius * 2);
            CGContextClipToRect(context, clipRect);
            CGContextAddEllipseInRect(context, CGRectMake(cx - r, cy - radius, r * 2, radius * 2));
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        } else {
            CGContextAddArc(context, cx, cy, radius, (CGFloat) toRadians(270), (CGFloat) toRadians(90), true);
            CGContextClosePath(context);
            CGContextFillPath(context);
            
            CGContextSaveGState(context);
            CGRect clipRect = CGRectMake(cx, cy - radius, r, radius * 2);
            CGContextClipToRect(context, clipRect);
            CGContextAddEllipseInRect(context, CGRectMake(cx - r, cy - radius, r * 2, radius * 2));
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }
    } else {                                                                                                      // 凹入的月
        if (start == 270) {
            CGContextSaveGState(context);
            CGRect clipRect = CGRectMake(cx, cy - radius, radius, radius * 2);
            CGContextClipToRect(context, clipRect);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddArc(path, nil, cx, cy, radius, (CGFloat) toRadians(90), (CGFloat) toRadians(270), true);
            CGPathAddEllipseInRect(path, nil, CGRectMake(cx - r, cy - radius, r * 2, radius * 2));
            
            CGContextAddPath(context, path);
            CGContextFillPath(context);
            
            CGPathRelease(path);
            CGContextRestoreGState(context);
        } else {
            CGContextSaveGState(context);
            CGRect clipRect = CGRectMake(cx - radius, cy - radius, radius, radius * 2);
            CGContextClipToRect(context, clipRect);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddArc(path, nil, cx, cy, radius, (CGFloat) toRadians(270), (CGFloat) toRadians(90), true);
            CGPathAddEllipseInRect(path, nil, CGRectMake(cx - r, cy - radius, r * 2, radius * 2));
            
            CGContextAddPath(context, path);
            CGContextFillPath(context);
            
            CGPathRelease(path);
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *backgroundImageOverlay = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return backgroundImageOverlay;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
