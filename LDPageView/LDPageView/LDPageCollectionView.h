//
//  LDPageCollectionView.h
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/25.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDPageTitleStyle.h"
#import "LDPageTitleView.h"
#import "LDPageCollectionViewLayout.h"

@class LDPageCollectionView;

@protocol LDPageCollectionViewDataSource <NSObject>

@required
- (NSInteger)numberOfSectionsInPageCollectionView:(LDPageCollectionView *)pageCollectionView;

- (NSInteger)pageCollectionView:(LDPageCollectionView *)pageCollectionView numberOfItemsInSection:(NSInteger)section;

- (UICollectionViewCell *)pageCollectionView:(LDPageCollectionView *)pageCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LDPageCollectionView : UIView

/** dataSource */
@property (nonatomic, weak) id<LDPageCollectionViewDataSource> dataSource;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(LDPageTitleStyle *)style;

/** layout */
@property (nonatomic, strong) LDPageCollectionViewLayout *layout;

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;

- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)reloadData;

@end
