//
//  ViewController.m
//  emojiDemo
//
//  Created by Emy on 2018/9/8.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "ViewController.h"
#import "NSString+emoji.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiEncodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiDecodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *TextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TextField.delegate = self;
    [self.TextField addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)sender {
    self.textLabel.text = sender.text;
    self.emojiEncodeLabel.text = [sender.text emojiEncode];
    self.emojiDecodeLabel.text = [[sender.text emojiEncode]emojiDecode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
