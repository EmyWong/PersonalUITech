//
//  RootViewController.m
//  CustomProgressHud
//
//  Created by 王颜华 on 16/4/18.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

#import "RootViewController.h"
#import "ProgressHUD.h"
@interface RootViewController ()
@property ProgressHUD *progressHUD;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"神马新闻";
    
    self.progressHUD = [ProgressHUD new];
    [self.progressHUD inView:self.view];
    [self.progressHUD tintColor:[UIColor orangeColor]];
    [self.progressHUD bgcolor:[UIColor whiteColor]];
    [self.progressHUD show];
    
    
    

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.progressHUD.isShowing == YES) {
        [self.progressHUD finish];
    }
    else
    {
        [self.progressHUD show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
