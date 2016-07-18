//
//  ViewController.m
//  Demo
//
//  Created by 王颜华 on 16/7/14.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    self.webView.delegate = self;
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openWeb) name:@"openWeb" object:nil];

    self.activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.activityIndicatorView.center=self.view.center;
    [self.activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicatorView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.activityIndicatorView];
}
- (void)openWeb
{
    NSURL* url = [NSURL URLWithString:@"http://60.208.20.232:50000/gamop/sys/sysApp/Office/iosNews"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicatorView startAnimating];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
