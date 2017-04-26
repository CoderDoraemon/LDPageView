//
//  LDPageCollectionView.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/25.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDPageCollectionView.h"



@interface LDPageCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, LDPageTitleViewDelegate>

/** titles */
@property (nonatomic, strong) NSArray *titles;

/** style */
@property (nonatomic, strong) LDPageTitleStyle *style;

/** titleView */
@property (nonatomic, strong) LDPageTitleView *titleView;

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** pageControl */
@property (nonatomic, strong) UIPageControl *pageControl;

/** 当前的组 */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

/** currentIndexArray */
@property (nonatomic, strong) NSMutableArray *currentIndexArray;

@end

@implementation LDPageCollectionView



- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(LDPageTitleStyle *)style {
    
    self.titles = titles;
    self.style = style;
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    for (int i = 0; i < self.titles.count; i++) {
        self.currentIndexArray[i] = [NSNumber numberWithInteger:0];
    }
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:self.titleView];
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    
//    [self pageTitleView:self.titleView didSelectedItemAtIndex:0];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInPageCollectionView:)]) {
        return [self.dataSource numberOfSectionsInPageCollectionView:self];
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        [self updatePageControlNumberOfIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    }
    
    if ([self.dataSource respondsToSelector:@selector(pageCollectionView:numberOfItemsInSection:)]) {
        
        return [self.dataSource pageCollectionView:self numberOfItemsInSection:section];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dataSource respondsToSelector:@selector(pageCollectionView:cellForItemAtIndexPath:)]) {
        return [self.dataSource pageCollectionView:self cellForItemAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - Public Mothods
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier {
    [self registerNib:nib forCellWithReuseIdentifier:identifier];
}


- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        [self scrollViewDidEndScroll];
    }
    
}

#pragma mark - LDPageTitleViewDelegate
- (void)pageTitleView:(LDPageTitleView *)pageTitleView didSelectedItemAtIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger sectionNum = [self.dataSource numberOfSectionsInPageCollectionView:self];
    NSInteger sectionItems = [self.dataSource pageCollectionView:self numberOfItemsInSection:index];
    
//    self.pageControl.numberOfPages = (sectionItems - 1) / (self.layout.columnNumber * self.layout.rowNumber) + 1;
//    self.pageControl.currentPage = 0;
    
    [self titleViewDidClickOfIndexPath:indexPath];
    
    CGPoint offSetPoint = self.collectionView.contentOffset;
    
    if (index == (sectionNum - 1) && sectionItems <= self.layout.columnNumber * self.layout.rowNumber) return;
    
    offSetPoint.x -= self.layout.sectionInset.left;
    
    self.collectionView.contentOffset = offSetPoint;
    
}

- (void)reloadData {
    [self.collectionView reloadData];
}


#pragma mark - Privte Mothods
- (void)scrollViewDidEndScroll {
    
    CGPoint point = CGPointMake(self.layout.sectionInset.left + 1 + self.collectionView.contentOffset.x, self.layout.sectionInset.top + 1);
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    if (indexPath == nil) return;
    
    if (indexPath.section != self.currentIndexPath.section) {
        
        [self updatePageControlNumberOfIndexPath:indexPath];
        
    }
    
    self.pageControl.currentPage = indexPath.item / (self.layout.columnNumber * self.layout.rowNumber);
    
    self.currentIndexArray[indexPath.section] = [NSNumber numberWithInteger:self.pageControl.currentPage];
    
}

- (void)updatePageControlNumberOfIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger sectionItems = [self.dataSource pageCollectionView:self numberOfItemsInSection:indexPath.section];
    
    self.pageControl.numberOfPages = (sectionItems - 1) / (self.layout.columnNumber * self.layout.rowNumber) + 1;
//    self.pageControl.currentPage = indexPath.item / (self.layout.columnNumber * self.layout.rowNumber);
    [self.titleView changeCurrentIndex:indexPath.section];
    
    self.currentIndexPath = indexPath;
    
}

- (void)titleViewDidClickOfIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger sectionItems = [self.dataSource pageCollectionView:self numberOfItemsInSection:indexPath.section];
    
    self.pageControl.numberOfPages = (sectionItems - 1) / (self.layout.columnNumber * self.layout.rowNumber) + 1;
    //    self.pageControl.currentPage = indexPath.item / (self.layout.columnNumber * self.layout.rowNumber);
    [self.titleView changeCurrentIndex:indexPath.section];
    
    self.currentIndexPath = indexPath;
    
    self.pageControl.currentPage = [self.currentIndexArray[indexPath.section] integerValue];
    
}

#pragma mark - lazy
- (LDPageTitleView *)titleView {
    if (_titleView == nil) {
        CGFloat titleViewY = self.style.isTilteInTop ? 0: self.bounds.size.height - self.style.titleViewHeight;
        _titleView = [[LDPageTitleView alloc] initWithFrame:CGRectMake(0, titleViewY, self.bounds.size.width, self.style.titleViewHeight) titles:self.titles titleStyle:self.style];
        _titleView.delegate = self;
    }
    return _titleView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        LDPageCollectionViewLayout *layout = [[LDPageCollectionViewLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        layout.columnNumber = 4;
        layout.rowNumber = 2;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        self.layout = layout;
        
        CGFloat collectionViewY = self.style.isTilteInTop ? self.style.titleViewHeight: 0;
        CGFloat collectionViewH = self.bounds.size.height - self.style.titleViewHeight - self.style.pageControlHeight;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionViewY, self.bounds.size.width, collectionViewH) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.bounds.size.width, self.style.pageControlHeight)];
    }
    return _pageControl;
}

- (NSMutableArray *)currentIndexArray {
    if (_currentIndexArray == nil) {
        _currentIndexArray = [NSMutableArray arrayWithCapacity:self.titles.count];
    }
    return _currentIndexArray;
}

@end
