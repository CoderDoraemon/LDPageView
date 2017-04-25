//
//  LDPageCollectionViewLayout.h
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/25.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDPageCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) UIEdgeInsets sectionInset;

/** 列数 */
@property (nonatomic, assign) NSInteger columnNumber;

/** 行数 */
@property (nonatomic, assign) NSInteger rowNumber;

@end
