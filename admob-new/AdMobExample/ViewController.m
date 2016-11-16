//
// Copyright (c) 2015 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  ViewController.m
//  AdMobExample
//

// [START firebase_banner_example]
#import "ViewController.h"
@import GoogleMobileAds;

@interface ViewController ()<GADBannerViewDelegate,GADInterstitialDelegate>
//横幅广告
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
//插页广告
@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBannerView];
    
    [self setInterstitial];
}

//初始化横幅广告
- (void)setBannerView {
    
    //设置横幅广告的尺寸大小，此处为智能横幅大小，即根据手机屏幕高度调整自身高度。
    self.bannerView.adSize = kGADAdSizeSmartBannerPortrait;
    
    //在横幅广告上设置一个广告单元 ID。您最终需要通过 AdMob 界面创建一个广告单元 ID 以在应用中使用。不过为方便起见，您可以使用下文中使用的测试广告单元 ID。
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
   
    //将包含 GADBannerView 的视图控制器设置为根视图控制器。 此视图控制器用于在用户点击广告后呈现叠加层。
    self.bannerView.rootViewController = self;
    
    //在请求广告之前先设置代理
    self.bannerView.delegate = self;
    
    //使用一个 GADRequest 对象在 GADBannerView 上调用 loadRequest:。
    [self.bannerView loadRequest:[GADRequest request]];
    
}
//初始化插页广告
- (void)setInterstitial {
    self.interstitial = [self createNewInterstitial];
}

//这个部分是因为多次调用 所以封装成一个方法
- (GADInterstitial *)createNewInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}

//按钮点击事件
- (IBAction)didTapInterstitialButton:(id)sender {
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
}

#pragma mark - GADBannerViewDelegate -

//在 loadRequest 时发送：已成功。这是将发送者添加到视图层次的好机会（如果到目前为止已隐藏视图层次）
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    //把隐藏的横幅广告显示出来
    bannerView.hidden = NO;
}

//当 loadRequest: 失败时发送，通常是网络故障、应用配置错误或缺少广告库存导致的。您可能希望记录这些事件以进行调试
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", error.localizedDescription);
}

#pragma mark - GADInterstitialDelegate -

//GADInterstitial 是仅限一次性使用的对象。若要请求另一个插页式广告，您需要分配一个新的 GADInterstitial 对象。
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    [self setInterstitial];
}

//分配失败重新分配
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    [self setInterstitial];
}

@end
// [END firebase_interstitial_example]
