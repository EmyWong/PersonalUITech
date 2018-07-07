//
//  EWWaterFallLayout.h
//  EWWaterFallLayout
//
//  Created by Emy on 2018/7/6.
//  Copyright © 2018年 Emy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EWWaterFallLayout;

@protocol EWWaterFallLayoutDataSource<NSObject>

@required
/**
  * 每个item的高度
  */
- (CGFloat)waterFallLayout:(EWWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetsInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout;

@end
                    
@interface EWWaterFallLayout : UICollectionViewLayout

/**
 * 代理
 */
@property (nonatomic, weak) id<EWWaterFallLayoutDataSource> delegate;

@end
