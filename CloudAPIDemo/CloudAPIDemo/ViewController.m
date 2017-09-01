//
//  ViewController.m
//  CloudAPIDemo
//
//  Created by zhenghaoMAC on 2017/8/30.
//  Copyright © 2017年 SomeOne. All rights reserved.
//

#import "ViewController.h"
#import <CloudKit/CloudKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //判断手机中的iCloud功能是否开启
    id cloudUrl = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (cloudUrl == nil) {
        NSLog(@"iCloud没有开启");
    } else {
        NSLog(@"iCloud开启");
    }
    [self addCloudDataWithPublic:YES recordName:@"1" name:@"wangyanhua" password:@"123"];
    [self addCloudDataWithPublic:YES recordName:@"2" name:@"zhouyi" password:@"456"];
//    [self searchRecordWithFormPublic:YES withRecordTypeName:@"User"];

}

//增加一条记录，可以给它一个固定的recordName，就想数据表的主键一样，查找、更新跟删除有用 可以根据实际情况修改
-(void)addCloudDataWithPublic:(BOOL)isPublic recordName:(NSString *)recordName name:(NSString *)name password:(NSString *)password
{
    //CloudKit给应用程序分配部分空间,用于存储数据,首先要获取这个存储空间,这里我们直接获取了默认的存储器(可以自定义存储器):
    CKContainer *container=[CKContainer defaultContainer];
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase; //公共数据
    }
    else
    {
        database=container.privateCloudDatabase;//隐藏数据
    }
    
    //创建主键ID  这个ID可以到时查找有用到
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordName];
    //创建CKRecord 保存数据
    CKRecord *noteRecord = [[CKRecord alloc]initWithRecordType:@"User" recordID:noteId];
    
    //设置数据
    [noteRecord setObject:name forKey:@"name"];
    [noteRecord setObject:password forKey:@"password"];
    
    //保存操作
    [database saveRecord:noteRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"保存成功");
        } else {
            NSLog(@"保存失败：%@",error);
        }
    }];
}

//增加带图片的提交 图片的保存,需要用到CKAsset,他的初始化需要一个URL,所以这里,我先把图片数据保存到本地沙盒,生成一个URL,然后再去创建CKAsset:
-(void)saveImageDataWithPublic:(BOOL)isPublic recordName:(NSString *)recordName name:(NSString *)name password:(NSString *)password imageName:(NSString *)imageName
{
    //保存图片 图片的保存,需要用到CKAsset,他的初始化需要一个URL,所以这里,我先把图片数据保存到本地沙盒,生成一个URL,然后再去创建CKAsset:
    UIImage *image=[UIImage imageNamed:imageName];
    NSData *imageData = UIImagePNGRepresentation(image);
    if (imageData == nil) {
        imageData = UIImageJPEGRepresentation(image, 0.6);
    }
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/imagesTemp"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:tempPath]) {
        
        [manager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",tempPath,imageName];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [imageData writeToURL:url atomically:YES];
    
    CKAsset *asset = [[CKAsset alloc]initWithFileURL:url];
    
    //与iCloud进行交互
    CKContainer *container=[CKContainer defaultContainer];
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase; //公共数据
    }
    else
    {
        database=container.privateCloudDatabase;//隐藏数据
    }
    
    //创建主键ID  这个ID可以到时查找有用到
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordName];
    //创建CKRecord 保存数据
    CKRecord *noteRecord = [[CKRecord alloc]initWithRecordType:@"User" recordID:noteId];
    
    //设置数据
    [noteRecord setObject:name forKey:@"name"];
    [noteRecord setObject:password forKey:@"password"];
    [noteRecord setObject:asset forKey:@"userImage"];
    
    //保存操作
    [database saveRecord:noteRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"保存成功");
        } else {
            NSLog(@"保存失败：%@",error);
        }
    }];
}

//查找单条记录
-(void)searchRecordWithRecordName:(NSString *)recordName withFormPublic:(BOOL)isPublic
{
    //获得指定的ID
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordName];
    
    //获得容器
    CKContainer *container=[CKContainer defaultContainer];
    
    //获得数据的类型 是公有还是私有
    CKDatabase *database;
    //如果是公有就存在公有数据库 私有则存在私有数据库
    if (isPublic) {
        database=container.publicCloudDatabase;
    }
    else
    {
        database=container.privateCloudDatabase;
    }
    //Block需要用self时弱引用self
    //__weak typeof(self)weakSelf = self;
    //查找操作
    [database fetchRecordWithID:noteId completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            NSString *message=[NSString stringWithFormat:@"获得RecordName为%@的数据：%@，%@",recordName,[record objectForKey:@"name"],[record objectForKey:@"password"]];
            NSLog(@"%@",message);
        } else {
            NSLog(@"查找失败：%@",error);
        }
    }];
}

//查找多条记录（可以用谓词进行）
-(void)searchRecordWithFormPublic:(BOOL)isPublic withRecordTypeName:(NSString *)recordTypeName
{
    CKContainer *container=[CKContainer defaultContainer];
    //获得数据的类型 是公有还是私有
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase;
    }
    else
    {
        database=container.privateCloudDatabase;
    }
    
    NSPredicate *predicate=[NSPredicate predicateWithValue:YES];
    CKQuery *query=[[CKQuery alloc]initWithRecordType:recordTypeName predicate:predicate];
    
//    __weak typeof(self)weakSelf = self;
    [database performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%@",results);
        } else {
            NSLog(@"查找失败：%@",error);
        }
    }];
}

//更新一条记录 首先要查找出这一条  然后再对它进行修改
-(void)updateRecordWithFormPublic:(BOOL)isPublic withRecordTypeName:(NSString *)recordTypeName withRecordName:(NSString *)recordName
{
    //获得指定的ID
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordName];
    
    //获得容器
    CKContainer *container=[CKContainer defaultContainer];
    
    //获得数据的类型 是公有还是私有
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase;
    }
    else
    {
        database=container.privateCloudDatabase;
    }
    
//    __weak typeof(self)weakSelf = self;
    //查找操作
    [database fetchRecordWithID:noteId completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            
            //对原有的健值进行修改
            [record setObject:@"changepwd" forKey:@"password"];
            //如果健值不存在 则会增加一个
            [record setObject:@"男" forKey:@"gender"];
            
            [database saveRecord:record completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"修改成功");
                }
                else
                {
                    NSLog(@"修改失败 ：%@",error);
                }
            }];
        }
    }];
}

//删除记录
-(void)deleteRecordWithFormPublic:(BOOL)isPublic withRecordName:(NSString *)recordName
{
    //获得指定的ID
    CKRecordID *noteId=[[CKRecordID alloc]initWithRecordName:recordName];
    
    //获得容器
    CKContainer *container=[CKContainer defaultContainer];
    
    //获得数据的类型 是公有还是私有
    CKDatabase *database;
    if (isPublic) {
        database=container.publicCloudDatabase;
    }
    else
    {
        database=container.privateCloudDatabase;
    }
    
//    __weak typeof(self)weakSelf = self;
    [database deleteRecordWithID:noteId completionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"删除成功");
            return;
        }
        NSLog(@"删除失败 %@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
