//
//  ViewController.m
//  EWWaterFallLayout
//
//  Created by Emy on 2018/7/6.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "ViewController.h"
#import "EWWaterFallLayout.h"

//随机色
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()<UICollectionViewDataSource,EWWaterFallLayoutDataSource>

@property (nonatomic,retain) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EWWaterFallLayout *layout = [[EWWaterFallLayout alloc] init];
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = randomColor;
    return cell;
}


- (CGFloat)waterFallLayout:(EWWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth {
    if (indexPath == 1) {
        return itemWidth * 1;
    } else {
        return itemWidth * 1.5;        
    }
}

- (NSUInteger)columnCountInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout {
    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
