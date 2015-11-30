//
//  ViewController.m
//  UIAlertController
//
//  Created by 王颜华 on 15/11/28.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UITextField *userTF;
@property (nonatomic,strong) UITextField *pwdTF;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    初始化两个TextField
    self.userTF = [[UITextField alloc]init];
    self.pwdTF = [[UITextField alloc]init];
}
#pragma mark 普通的AlertView
- (IBAction)AAction:(UIButton *)sender {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"这是一个普通的AlertView" preferredStyle:(UIAlertControllerStyleAlert)];
    //一个按钮 UIAlertActionStyleCancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertView addAction:cancelAction];
    
    //两个按钮 UIAlertActionStyleDefault
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:nil];
    [alertView addAction:defaultAction];
    
    //三个按钮 UIAlertActionStyleDestructive
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"没事试试" style:(UIAlertActionStyleDestructive) handler:nil];
    [alertView addAction:thirdAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
    
}
- (IBAction)BAction:(UIButton *)sender {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"这是一个带输入框的AlertView" preferredStyle:(UIAlertControllerStyleAlert)];
//    添加一个输入框 用于输入用户名
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        self.userTF = textField;
        //设置textField的属性
        textField.placeholder = @"请输入用户名";
    }];
//    再添加一个输入框 用于输入密码
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        self.pwdTF = textField;
        //设置textField的属性
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
    }];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"验证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@,%@",self.userTF.text,self.pwdTF.text);
        if ([self.userTF.text isEqualToString: @"admin"] && [self.pwdTF.text isEqualToString:@"123"]) {
            NSLog(@"验证成功");
        }
        else
        {
            NSLog(@"验证错误");
        }
    }];
    [alertView addAction:defaultAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
}
- (IBAction)CAction:(UIButton *)sender {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"恒信资管软件许可及服务协议" message:@"\n\n\n\n\n\n\n\n" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UITextView *txt = [[UITextView alloc]initWithFrame:CGRectMake(10, 47, 250, 145)];
    txt.backgroundColor = alertView.view.backgroundColor;
    txt.text = @"【首部及导言】  欢迎您使用恒信资管恒信资管软件及服务！  为使用恒信资管恒信资管软件（以下统称“本软件”）及服务，您应当阅读并遵守《恒信资管软件许可及服务协议》（以下简称“本协议”）。请您务必审慎阅读、充分理解各条款内容，特别是免除或者限制责任的条款，以及开通或使用某项服务的单独协议，并选择接受或不接受。限制、免责条款可能以加粗形式提示您注意。  除非您已阅读并接受本协议所有条款，否则您无权下载、安装或使用本软件及相关服务。您的下载、安装、使用、登录等行为即视为您已阅读并同意本协议的约束。  如果您未满18周岁，请在法定监护人的陪同下阅读本协议，并特别注意未成年人使用条款。   一、【协议的范围】  1.1【协议适用主体范围】  本协议是您与恒信资管之间关于您下载、安装、使用、登录本软件，以及使用本服务所订立的协议。 1.2【协议关系及冲突条款】  本协议的内容，包括但不限于以下与本服务、本协议相关的协议、规则、规范以及恒信资管可能不断发布的关于本服务的相关协议、规则、规范等内容，前述内容一经正式发布，即为本协议不可分割的组成部分，与其构成统一整体，您同样应当遵守：   二、【关于本服务】  2.1【本服务内容】  本服务内容是指恒信资管通过本软件向用户提供的相关服务（简称“本服务”）。 2.2【本服务形式】  您可能可以通过电脑、手机等终端以客户端、网页等形式使用本服务，具体以恒信资管提供的为准，同时，恒信资管会不断丰富您使用本服务的终端、形式等。当您使用本服务时，您应选择与您的终端、系统等相匹配的本软件版本，否则，您可能无法正常使用本服务。  2.3【许可的范围】  2.3.1 恒信资管给予您一项个人的、不可转让及非排他性的许可，以使用本软件。您可以为非商业目的在单一台终端设备上下载、安装、使用、登录本软件。  2.3.2 您可以制作本软件的一个副本，仅用作备份。备份副本必须包含原软件中含有的所有著作权信息。 2.3.3 本条及本协议其他条款未明示授权的其他一切权利仍由恒信资管保留，您在行使这些权利时须另外取得恒信资管的书面许可。恒信资管如果未行使前述任何权利，并不构成对该权利的放弃。   三、【软件的获取】  4.1 您可以直接从恒信资管的网站上获取本软件，也可以从得到恒信资管授权的第三方获取。  4.2 如果您从未经恒信资管授权的第三方获取本软件或与本软件名称相同的安装程序，恒信资管无法保证该软件能够正常使用，并对因此给您造成的损失不予负责。   四、【软件的安装与卸载】  5.1 恒信资管可能为不同的终端、系统等开发了不同的软件版本，您应当根据实际情况选择下载合适的版本进行安装。";
//    取消textView的可编辑
    txt.editable = NO;
    
    [alertView.view addSubview:txt];
    
    //一个按钮 UIAlertActionStyleCancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不同意" style:(UIAlertActionStyleCancel) handler:nil];
    [alertView addAction:cancelAction];
    
    //两个按钮 UIAlertActionStyleDefault
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"同意" style:(UIAlertActionStyleDefault) handler:nil];
    [alertView addAction:defaultAction];

    [self presentViewController:alertView animated:YES completion:nil];
}
- (IBAction)DAction:(UIButton *)sender {
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"这是一个普通的AlertSheet" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    //一个按钮 UIAlertActionStyleCancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertSheet addAction:cancelAction];
    
    //两个按钮 UIAlertActionStyleDefault
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:nil];
    [alertSheet addAction:defaultAction];
    
    //三个按钮 UIAlertActionStyleDestructive(破灭性的，毁灭性的，用于不可恢复的操作)
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"没事试试" style:(UIAlertActionStyleDestructive) handler:nil];
    [alertSheet addAction:thirdAction];
    
    [self presentViewController:alertSheet animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
