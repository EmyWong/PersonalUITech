//
//  ViewController.m
//  BlockDemo
//
//  Created by Emy on 2020/6/18.
//  Copyright © 2020 Emy. All rights reserved.
//

#import "ViewController.h"
#import "BlockViewController.h"
#import "Calculator.h"
#import "Person.h"
/**
 Block本质请移步至main.m文件 结合c++文件main.cpp文件查看
 */
@interface ViewController ()

@property (nonatomic, strong) NSArray *blockArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self blockTest1];
//    [self blockTest2];
//    [self blockTest3];
//    [self blockTest4];
//    [self blockTest5];
//    [self blockTest6];
//    [self blockTest7];
//    [self blockTest8];
//    [self linkCall];
    
}

//返回类型(^Block名称)(参数类型)
- (void)blockTest1 {
    //无参数无返回值
    void (^ printBlock)(void) = ^{
        NSLog(@"print block");
    };
    printBlock();

    //有参数无返回值
    void (^ combineBlock)(NSString *str, NSNumber *num) = ^(NSString *str, NSNumber *num) {
        NSString *combineStr = [NSString stringWithFormat:@"%@-%@", str, num];
        NSLog(@"combine block: %@", combineStr);
    };
    combineBlock(@"str", @1);

    int (^ caculateBlock)(int value1, int value2) = ^(int value1, int value2) {
        return value1 + value2;
    };
    int sum = caculateBlock(1000, 24);
    NSLog(@"caculate block: %d", sum);

    typedef NSString *(^ConvertBlock)(int value);
    ConvertBlock block = ^(int value) {
        return [NSString stringWithFormat:@"convert-%d", value];
    };
    NSString *convertStr = block(1);
    NSLog(@"convert block: %@", convertStr);
}

//作为函数参数:通常在进行一些异步操作时，我们都会使用block作为函数参数来回调结果
- (void)blockTest2 {
    [self doSomethingWithCompletion:^(BOOL success) {
        NSLog(@"do something finished with %@", (success ? @"YES" : @"NO"));
    }];
}

- (void)doSomethingWithCompletion:(void (^)(BOOL success))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion(YES);
        }
    });
}

//作为返回值：通常将block作为函数返回值处理的场景会比较少，不过后面讲到的链式调用就会通过该形式实现。
- (void)blockTest3 {
    NSString * (^ convertBlock)(void) = [self createBlockWithValue:1];
    NSString *convertStr = convertBlock();
    NSLog(@"convert block: %@", convertStr);
}

- (NSString *(^)(void))createBlockWithValue:(int)value {
    return ^{
        return [NSString stringWithFormat:@"str-%d", value];
    };
}

//作为成员变量：可以通过设置成员变量为block来通知外部调用者，从而达成两者数据的传递。
- (void)blockTest4 {
    BlockViewController *blockVC = [[BlockViewController alloc] init];
    blockVC.blockTest = ^(NSString *_Nonnull result) {
        NSLog(@"block result: %@", result); //通知外层
    };
    [self.navigationController pushViewController:blockVC animated:YES];
}

//__block修饰符:当需要在block内修改局部变量时，需要通过__block修饰符定义，否则只能读取，不能修改。
- (void)blockTest5 {
    int value1 = 1;
    void (^ onlyreadBlock)(void) = ^{
        NSLog(@"only read block: %d", value1);
    };
    onlyreadBlock();

    __block int value2 = 1;
    void (^ processBlock)(void) = ^{
        value2 = 2;
        NSLog(@"process block: %d", value2);
    };

    processBlock();
}

//__weak和__strong修饰符:为了避免循环引用，通常在block内会将self转化为weakSelf，但为什么有时候还需要使用strongSelf呢？其实，这里主要是因为block内部的weakSelf不知道什么时候会被释放掉，对第一个block，若weakSlef被释放了，就不会调用doSecondThing方法，这样通常不会导致什么错误发生，但对于第二个block，如果继续沿用weakSelf，假设weakSelf在执行完doSecondThing之后被释放掉，doThirdThing就不会被调用，意味着只执行了一个方法，这就很容易引发一些不可预见的情况。因此，为了保证代码的完整性，block内部使用__strong修饰符，这样weakSelf在未被释放的情况下进入block，block在执行完前都不会被释放。
- (void)blockTest6 {
    __weak typeof(self) weakSelf = self;
    [self doSomethingWithCompletion:^(BOOL success) {
        [weakSelf doSecondThing];
    }];

    [self doSomethingWithCompletion:^(BOOL success) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf doSecondThing];
            [strongSelf doThirdThing];
        }
    }];
}

- (void)doSecondThing {
    NSLog(@"do second thing");
}

- (void)doThirdThing {
    NSLog(@"do third thing");
}

//lazy loading
- (NSArray *)blockArray {
    /**
     访问局部变量，所以这时候创建的Block是NSStackBlock，存储在栈中，没有对其赋值也没有copy，所以不会被拷贝到堆中，局部变量作用域执行完后会被立即回收，出现野指针。
     */
//    int val = 10;
//    return [NSArray arrayWithObjects:^() { NSLog(@"blk0: %d", val); }, ^() { NSLog(@"blk1: %d", val); }, ^() { NSLog(@"blk2: %d", val); }, nil];
    
    /**
     不访问局部变量，就是全局类型NSGlobalBlock，直到程序结束才回收，所以不会造成野指针
     */
    return [NSArray arrayWithObjects:^() { NSLog(@"blk0: %d", 10); }, ^() { NSLog(@"blk1: %d", 10); }, ^() { NSLog(@"blk2: %d", 10); }, nil];

    /**
     进行赋值之后就会被拷贝到堆区成为NSMallocBlock类型
     */
//    typedef void (^blk)(void);
//    blk block1 = ^() { NSLog(@"blk0: %d", val); };
//    blk block2 = ^() { NSLog(@"blk1: %d", val); };
//    blk block3 = ^() { NSLog(@"blk2: %d", val); };
//    return [NSArray arrayWithObjects:block1, block2,  block3, nil];
}

- (void)blockTest7 {
    NSArray *blocks = [self blockArray];
    typedef void (^blk)(void);
    for (NSInteger index = 0; index < blocks.count; index++) {
        blk block = blocks[index];
        if (block) {
            block();
        }
        NSLog(@"blk-%ld: %@", index, block);
    }
}

//此处需要禁用此文件arc的功能才能看到NSStackBlock
- (void)blockTest8 {
    void(^globalBlock)(void) = ^{
        NSLog(@"global Block");
    }; //__NSGlobalBlock__: 存储在数据段（一般用来存储全局变量、静态变量等，直到程序结束时才会回收）中，block内未访问了局部变量
    
    int value = 1;
    void(^stackBlock)(void) = ^{
        NSLog(@"stack block: %d", value);
    };//__NSStackBlock__: 存储在栈（一般用来存储局部变量，自动分配内存，当局部变量作用域执行完后会被立即回收）中，block内访问了局部变量。在ARC下，该Blcok为NSMallocBlock，因为ARC下，当对栈block进行赋值操作时，编译器会自动将其拷贝到堆中。
    
    void(^mallocBlock)(void) = [stackBlock copy];//__NSMallocBlock__: 存储在堆（alloc出来的对象，由开发者进行管理）中，当__NSStackBlock__进行copy操作时
    
    NSArray *blocks = [[NSArray alloc] initWithObjects:globalBlock, stackBlock, mallocBlock, nil];
    
    for (id blk in blocks) {
        NSLog(@"blk: %@", blk);
    }
}

//链式调用 在Masonry中有同样的用法
- (void)linkCall {
    Calculator *cal = [[Calculator alloc] initWithValue:2];
    cal.add(5).divide(10).multiply(2).sub(8);
    NSLog(@"%ld",(long)cal.result);
}

//测试copy修饰的字符串地址
- (void)testCopy {
    {
        //直接赋值地址
        NSString *str1 = @"小花";
        NSString *str2 = [str1 copy];
        NSLog(@"str1 %@ %p",str1,str1);
        NSLog(@"str2 %@ %p",str2,str2);
        str1 = @"花菜";
        NSLog(@"str1 %@ %p",str1,str1);
        NSLog(@"str2 %@ %p",str2,str2);
    }
    
    {
        //间接赋值地址
        NSString *str = @"小花";
        NSLog(@"str %@ %p",str,str);
        NSString *str1 = str;
        NSString *str2 = [str1 copy];
        NSLog(@"str1 %@ %p",str1,str1);
        NSLog(@"str2 %@ %p",str2,str2);
        str = @"花菜";
        NSLog(@"str %@ %p",str,str);
        NSLog(@"str1 %@ %p",str1,str1);
        NSLog(@"str2 %@ %p",str2,str2);
    }
    //结论：当copy拷贝的是不可变的字符串的时候，它拷贝的是一个指针，指向被拷贝对象的值和地址。
}

//测试copy和strong修饰的字符串地址
- (void)testCopyAndStrong {
    {
        //直接赋值
        Person *p1 = [[Person alloc] init];
        p1.strCopy = @"小明";
        p1.strStrong = @"王小明";
        NSLog(@"strCopy   %@ %p",p1.strCopy,p1.strCopy);
        NSLog(@"strStrong %@ %p",p1.strStrong,p1.strStrong);
        //修改
        p1.strCopy = @"小明明";
        p1.strStrong = @"王大明";
        NSLog(@"strCopy   %@ %p",p1.strCopy,p1.strCopy);
        NSLog(@"strStrong %@ %p",p1.strStrong,p1.strStrong);
        //修改后地址都会改变，相当于一级指针指向新值。
    }
    
    {
        //间接赋值
        NSString *string = @"明明";
        NSLog(@"string    %@ %p",string,string);

        Person *p1 = [[Person alloc] init];
        p1.strCopy = string;
        p1.strStrong = string;
        NSLog(@"strCopy   %@ %p",p1.strCopy,p1.strCopy);
        NSLog(@"strStrong %@ %p",p1.strStrong,p1.strStrong);
        //修改
        string = @"很爱你";
        NSLog(@"string    %@ %p",string,string);
        NSLog(@"strCopy   %@ %p",p1.strCopy,p1.strCopy);
        NSLog(@"strStrong %@ %p",p1.strStrong,p1.strStrong);
        //修改后值和地址没变，没有影响。
    }
    
    {
        //测试NSMutableString间接赋值
        NSMutableString *string = [NSMutableString stringWithFormat:@"明明"];
        NSLog(@"string   %@ %p",string,string);

        Person *p1 = [[Person alloc] init];
        p1.strCopy = string;
        p1.strStrong = string;
        NSLog(@"strCopy   %@ %p",p1.strCopy,p1.strCopy);
        NSLog(@"strStrong %@ %p",p1.strStrong,p1.strStrong);
        //修改
        [string appendFormat:@"很爱你"];
        NSLog(@"string   %@ %p",string,string);
        NSLog(@"strCopy   %@ %p",p1.strCopy,p1.strCopy);
        NSLog(@"strStrong %@ %p",p1.strStrong,p1.strStrong);
        //copy修饰的字符串地址变了，strong修饰的字符串直接指向原地址。
    }

    
    /*
     总结：
     1.NSString的字符串的对象的值改变时，会开辟一块新的内存，NSMutableString的字符串的对象的值改变时，依旧是原地址。
      2.copy拷贝NSSting字符串时，拷贝指针，即浅拷贝；copy拷贝NSMutableString字符串时是重新生成一个新对象，即深拷贝。copy修饰的可变字符串属性类型始终是NSString，而不是NSMutableString，如果想让拷贝过来的对象是可变的，就要使用mutableCopy。(所有copy修饰的NSSting字符串不会被外界影响)3.strong表示强指向，对可变和不可变字符串都只有浅拷贝。对NSMutableString不存在深拷贝。
     */
    
}


@end
