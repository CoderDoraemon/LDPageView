//
//  LDCollectionViewLayout.h
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/24.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDCollectionViewLayout;

@protocol LDCollectionViewLayoutDelegate <NSObject>

@required
- (CGFloat)ld_collectionView:(UICollectionView *)collectionView layout:(LDCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath widthForItem:(CGFloat)width;


@optional
//- (CGFloat)ld_collectionView:(UICollectionView *)collectionView layout:(LDCollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//
//- (CGFloat)ld_collectionView:(UICollectionView *)collectionView layout:(LDCollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//
//- (NSInteger)ld_collectionView:(UICollectionView *)collectionView layout:(LDCollectionViewLayout *)collectionViewLayout columnNumberForSectionAtIndex:(NSInteger)section;
//
//- (UIEdgeInsets)ld_collectionView:(UICollectionView *)collectionView layout:(LDCollectionViewLayout *)collectionViewLayout sectionInsetForSectionAtIndex:(NSInteger)section;

@end

@interface LDCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) NSInteger columnNumber;

/** 布局代理 */
@property (nonatomic, weak) id<LDCollectionViewLayoutDelegate> delegate;

@end
