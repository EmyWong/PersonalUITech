//
//  EWWaterFallLayout.m
//  EWWaterFallLayout
//
//  Created by Emy on 2018/7/6.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import "EWWaterFallLayout.h"

/** 默认的列数 */
static const CGFloat EWDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat EWDefaultColumnMargin = 10;
/** 每一行之间的间距 **/
static const CGFloat EWDefaultFRowMargin = 10;
/** 内边距 */
static const UIEdgeInsets EWDefaultEdgeInsets = {10,10,10,10};

@interface EWWaterFallLayout()
/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArr;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;

- (NSUInteger)columnCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation EWWaterFallLayout

#pragma mark 懒加载
- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

#pragma mark 数据处理
/**
  * 列数
 */
- (NSUInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFallLayout:)]) {
        return [self.delegate columnCountInWaterFallLayout:self];
    } else {
        return EWDefaultColumnCount;
    }
}

/**
 * 列间距
 */
- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFallLayout:)]) {
        return [self.delegate columnMarginInWaterFallLayout:self];
    } else {
        return EWDefaultColumnMargin;
    }
}

/**
 * 行间距
 */
- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFallLayout:)]) {
        return [self.delegate rowMarginInWaterFallLayout:self];
    } else {
        return EWDefaultFRowMargin;
    }
}

/**
 * item的内边距
 */
- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFallLayout:)]) {
        return [self.delegate edgeInsetsInWaterFallLayout:self];
    } else {
        return EWDefaultEdgeInsets;
    }
}

/**
 * 初始化
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    //清除之前计算的所有高度
    [self.columnHeights removeAllObjects];
    
    //设置每一列默认的高度
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(EWDefaultEdgeInsets.top)];
    }
    
    //清除之前所有的布局属性
    [self.attrsArr removeAllObjects];
    
    //开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //获取indexPath位置上cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArr addObject:attrs];
    }
}
/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    //设置布局属性的frame
    CGFloat cellW = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat cellH = [self.delegate waterFallLayout:self heightForItemAtIndexPath:indexPath.item itemWidth:cellW];
    //找出最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i = 0; i < self.columnCount; i++) {
        //取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat cellX = self.edgeInsets.left + destColumn * (cellW + self.columnMargin);
    CGFloat cellY = minColumnHeight;
    if (cellY != self.edgeInsets.top) {
        cellY += self.rowMargin;
    }
    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
    //更新最短那一列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    //记录内容的高度 - 即最长那一列的高度
    CGFloat maxColumnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < maxColumnHeight) {
        self.contentHeight = maxColumnHeight;
    }
    return attrs;
}

/**
 * 决定cell的布局属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArr;
}

/**
 * 内容的高度
 */
- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end
