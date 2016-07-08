//
//  ViewController.m
//  ReadAddressBookDemo
//
//  Created by 王颜华 on 16/7/7.
//  Copyright © 2016年 王颜华. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//新建一个联系人
- (IBAction)AddContact:(UIButton *)sender
{
#pragma mark 联系人对象:CNContact
    //创建一个CNMutableContact对象
    CNMutableContact *contact = [[CNMutableContact alloc]init];
    //设置联系人对象
    contact.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"tx.png"]);
    //设置联系人名字
    contact.givenName = @"Yanhua";
    //设置联系人姓氏
    contact.familyName = @"Wong";
    
    //设置联系人邮箱
    CNLabeledValue *homeEmail = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:@"emywong@sina.com"];
    CNLabeledValue *workEmail = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:@"wangyanhua@dareway.com.cn"];
    //将添加到的家庭邮箱和工作邮箱加入到emailAddress数组中
    contact.emailAddresses = @[homeEmail,workEmail];
    
    //设置联系人电话
    CNLabeledValue *iPhoneNo = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:@"15154298103"]];
    //将iPhone类电话添加到phoneNumbers中
    contact.phoneNumbers = @[iPhoneNo];
    
    //设置联系人地址
    CNMutablePostalAddress *address = [[CNMutablePostalAddress alloc]init];
    address.street = @"崂山街道";
    address.city = @"威海市";
    address.state = @"山东省";
    address.country = @"中国";
    address.postalCode = @"40号";
    CNLabeledValue *postalAddress = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:address];
    
    contact.postalAddresses = @[postalAddress];
    
    //设置生日
    NSDateComponents *birthday = [[NSDateComponents alloc]init];
    birthday.day = 5;
    birthday.month = 2;
    birthday.year = 1995;
    contact.birthday = birthday;
#pragma mark 创建添加联系人请求:CNSaveRequest
    //初始化方法
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc]init];
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    
#pragma mark 进行联系人的写入操作:CNContactStore
    //初始化
    CNContactStore *contactStore = [[CNContactStore alloc]init];
    [contactStore executeSaveRequest:saveRequest error:nil];
    
}
- (IBAction)PresentContact:(UIButton *)sender {
    
    //打开原生的通讯录ViewController
    CNContactPickerViewController *contactPickerViewController = [[CNContactPickerViewController alloc]init];
    //数据库的查询条件 姓名不能为空
    contactPickerViewController.predicateForEnablingContact = [NSPredicate predicateWithFormat:@"name != nil"];
    //设置代理
    contactPickerViewController.delegate = self;
    //模态出联系人界面
    [self presentViewController:contactPickerViewController animated:YES completion:nil];
    
}
#pragma mark CNContactPickerDelegate
// 当选中某一个联系人时会执行该方法
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    
    // 1.获取联系人的姓名
    NSString *lastname = contact.familyName;
    NSString *firstname = contact.givenName;
    NSLog(@"%@ %@", lastname, firstname);
    
    // 2.获取联系人的电话号码
    NSArray *phoneNums = contact.phoneNumbers;
    for (CNLabeledValue *labeledValue in phoneNums) {
        // 2.1.获取电话号码的KEY
        NSString *phoneLabel = labeledValue.label;
        
        // 2.2.获取电话号码
        CNPhoneNumber *phoneNumer = labeledValue.value;
        NSString *phoneValue = phoneNumer.stringValue;
        
        NSLog(@"%@ %@", phoneLabel, phoneValue);
    }
    
    self.contactLabel.text = [NSString stringWithFormat:@"紧急联系人：%@%@",lastname,firstname];
}
// 当选中某一个联系人的某一个属性时会执行该方法
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{

}

// 点击了取消按钮会执行该方法
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
