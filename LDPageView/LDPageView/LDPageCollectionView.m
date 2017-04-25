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
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:self.titleView];
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInPageCollectionView:)]) {
        return [self.dataSource numberOfSectionsInPageCollectionView:self];
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
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

#pragma mark - LDPageTitleViewDelegate
- (void)pageTitleView:(LDPageTitleView *)pageTitleView didSelectedItemAtIndex:(NSInteger)index {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    CGPoint offSetPoint = self.collectionView.contentOffset;
    
    offSetPoint.x -= self.layout.sectionInset.left;
    
    self.collectionView.contentOffset = offSetPoint;
}

- (void)reloadData {
    [self.collectionView reloadData];
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
        _pageControl.numberOfPages = 4;
    }
    return _pageControl;
}

@end
