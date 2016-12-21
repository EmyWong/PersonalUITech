//
//  ViewController.m
//  UUIDAndKeyChain
//
//  Created by Dareway on 2016/12/21.
//  Copyright © 2016年 Dareway. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //从钥匙串读取UUID
    NSString *retrieveuuid = [SSKeychain passwordForService:@"com.yourapp.yourcompany"account:@"user"];
    if (!retrieveuuid) {
        //创建一个UUID
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        assert(uuid != NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        //存储到钥匙串中
        [SSKeychain setPassword: [NSString stringWithFormat:@"%@", uuidStr]
                     forService:@"com.yourapp.yourcompany"account:@"user"];
    }else {
        NSLog(@"%@",retrieveuuid);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
