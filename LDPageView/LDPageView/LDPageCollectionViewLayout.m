//
//  LDPageCollectionViewLayout.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/25.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDPageCollectionViewLayout.h"

@interface LDPageCollectionViewLayout ()

/** LayoutAttributes */
@property (nonatomic, strong) NSMutableArray *layoutAttributes;



/** previousNumOfPage */
@property (nonatomic, assign) NSInteger previousNumOfPage;

/** itemSize */
@property (nonatomic, assign) CGSize itemSize;

/** contentHeight */
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation LDPageCollectionViewLayout

- (void)prepareLayout {
    
    self.previousNumOfPage = 0;
    
    CGFloat itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * (self.columnNumber - 1)) / self.columnNumber;
    CGFloat itemH = (self.collectionView.bounds.size.height - self.sectionInset.top - self.sectionInset.bottom - self.minimumLineSpacing * (self.rowNumber - 1)) / self.rowNumber;
    self.itemSize = CGSizeMake(itemW, itemH);
    
    NSInteger sections = [self.collectionView numberOfSections];
    
    for (int i = 0; i < sections; i++) {
        
        NSInteger items = [self.collectionView numberOfItemsInSection:i];
        
        for (int j = 0; j < items; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            
            UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [self.layoutAttributes addObject:layoutAttributes];
        }
        
        self.previousNumOfPage += (items - 1) / (self.columnNumber * self.rowNumber) + 1;
        
    }
    
    self.contentHeight = self.previousNumOfPage * self.collectionView.bounds.size.width;
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger currentPage = indexPath.item / (self.columnNumber * self.rowNumber);
    NSInteger currentIndex = indexPath.item % (self.columnNumber * self.rowNumber);
    
    CGFloat layoutAttributesX = (self.previousNumOfPage + currentPage) * self.collectionView.bounds.size.width + self.sectionInset.left + (self.itemSize.width + self.minimumInteritemSpacing) * (currentIndex % self.columnNumber);
    CGFloat layoutAttributesY = self.sectionInset.top + (self.itemSize.height + self.minimumLineSpacing) * (currentIndex / self.columnNumber);
    
    layoutAttributes.frame = CGRectMake(layoutAttributesX, layoutAttributesY, self.itemSize.width, self.itemSize.height);
    
    return layoutAttributes;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.layoutAttributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentHeight, 0);
}

#pragma mark - lazy
- (NSMutableArray *)layoutAttributes {
    if (_layoutAttributes == nil) {
        _layoutAttributes = [NSMutableArray array];
    }
    return _layoutAttributes;
}

@end
