//
//  LDCollectionViewLayout.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/24.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDCollectionViewLayout.h"

/** 默认的列数 */
static const NSInteger kDefaultColumnCount = 3;

/** 每一列之间的间距 */
static const CGFloat kMinimumLineSpacing = 10;

/** 每一行之间的间距 */
static const CGFloat kMinimumInteritemSpacing = 10;

/** 边缘间距 */
static const UIEdgeInsets kDefaultEdgeInsets = {10, 10, 10, 10};

@interface LDCollectionViewLayout ()

/** LayoutAttributes */
@property (nonatomic, strong) NSMutableArray *layoutAttributes;

/** columnHeights */
@property (nonatomic, strong) NSMutableArray *columnHeights;

/** contentHeight */
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation LDCollectionViewLayout

- (void)prepareLayout {
    
    self.contentHeight = 0;
    
    self.minimumInteritemSpacing = kMinimumInteritemSpacing;
    self.minimumLineSpacing = kMinimumLineSpacing;
    self.sectionInset = kDefaultEdgeInsets;
    self.columnNumber = kDefaultColumnCount;
    
    for (int m = 0; m < self.columnNumber; m++) {
        self.columnHeights[m] = [NSNumber numberWithFloat:self.sectionInset.top];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; self.layoutAttributes.count < count; i++) {
        
        @autoreleasepool {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            
            UICollectionViewLayoutAttributes *layoutAttribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [self.layoutAttributes addObject:layoutAttribute];
            
        }
        
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnNumber - 1) * self.minimumInteritemSpacing) / self.columnNumber;
    
    CGFloat itemH = [self.delegate ld_collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath widthForItem:itemW];
    
    // 计算当前item应该摆放在第几列(计算哪一列高度最短)
    NSInteger destColumn = 0;
    // 默认是第0列
    CGFloat miniHeight = [self.columnHeights[0] doubleValue];
    
    for (int i = 0 ; i < self.columnNumber; i++) { // 遍历找出最小高度的列
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (miniHeight > columnHeight) {
            miniHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat itemX = self.sectionInset.left + destColumn * (itemW + self.minimumInteritemSpacing);
    
    CGFloat itemY = miniHeight;
    
    if (itemY != self.sectionInset.top) {
        itemY += self.minimumLineSpacing;
    }
    
    layoutAttributes.frame = CGRectMake(itemX, itemY, itemW, itemH);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(layoutAttributes.frame));
    
    // 记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    
    
    
    return layoutAttributes;
    
}

- (CGSize)collectionViewContentSize {
    
    //    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    //    for (NSInteger i = 1; i < self.columnCount; i++) {
    //        // 取得第i列的高度
    //        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
    //
    //        if (maxColumnHeight < columnHeight) {
    //            maxColumnHeight = columnHeight;
    //        }
    //    }
    
    return CGSizeMake(0, self.contentHeight + self.sectionInset.bottom);
}


#pragma mark - lazy
- (NSMutableArray *)layoutAttributes {
    if (_layoutAttributes == nil) {
        _layoutAttributes = [NSMutableArray array];
    }
    return _layoutAttributes;
}


- (NSMutableArray *)columnHeights {
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

//- (CGFloat)minimumLineSpacing {
//    if ([self.delegate respondsToSelector:@selector(ld_collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
//        return [self.delegate ld_collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:0];
//    }
//    return kMinimumLineSpacing;
//}
//
//- (CGFloat)minimumInteritemSpacing {
//    if ([self.delegate respondsToSelector:@selector(ld_collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
//        return [self.delegate ld_collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:0];
//    }
//    return kMinimumInteritemSpacing;
//}
//
//- (UIEdgeInsets)sectionInset {
//    if ([self.delegate respondsToSelector:@selector(ld_collectionView:layout:sectionInsetForSectionAtIndex:)]) {
//        return [self.delegate ld_collectionView:self.collectionView layout:self sectionInsetForSectionAtIndex:0];
//    }
//    return kDefaultEdgeInsets;
//}

@end
