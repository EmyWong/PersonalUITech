//
//  IndexedTableView.h
//  CustomLetterIndexView
//
//  Created by Emy on 2018/8/14.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexedTableViewDataSource <NSObject>

//获取一个TableView的字母索引条数据的方法
- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;

@end

@interface IndexedTableView : UITableView

@property (nonatomic, weak) id<IndexedTableViewDataSource> indexedDataSource;

@end
