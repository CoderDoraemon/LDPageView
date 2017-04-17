//
//  LDPageContentView.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDPageContentView.h"
#import "LDPageTitleView.h"

static NSString *const LDPageContentViewCollectionViewCellIdentifier = @"LDPageContentViewCollectionViewCellIdentifier";

@interface LDPageContentView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation LDPageContentView

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray<UIViewController *> *)childViewControllers {
    
    self.childViewControllers = childViewControllers;
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.collectionView.frame = self.bounds;
    [self addSubview:self.collectionView];
    
}

#pragma mark - Mothods
- (void)pageContentViewDidEndScroll {
    
    NSInteger currentIndex = self.collectionView.contentOffset.x / self.bounds.size.width;
    
    if ([self.delegate respondsToSelector:@selector(pageContentView:didEndScrollAtindex:)]) {
        [self.delegate pageContentView:self didEndScrollAtindex:currentIndex];
    }
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LDPageContentViewCollectionViewCellIdentifier forIndexPath:indexPath];
    
    UIViewController *vc = self.childViewControllers[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self pageContentViewDidEndScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        [self pageContentViewDidEndScroll];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.currentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger currentIndex = self.currentOffsetX / self.bounds.size.width;
    
    NSInteger targetIndex = currentIndex;
    
    CGFloat progress = 0;
    
    CGFloat delta = 0;
    
    if (scrollView.contentOffset.x - self.currentOffsetX < 0) { // 向右滑动 索引减小
        
        targetIndex = currentIndex - 1;
        
        if (targetIndex < 0) {
            targetIndex = 0;
        }
        
        delta = self.currentOffsetX - scrollView.contentOffset.x;
    } else { // 向左滑动 索引增大
        targetIndex = currentIndex + 1;
        
        if (targetIndex > self.childViewControllers.count) {
            targetIndex = self.childViewControllers.count - 1;
        }
        
        delta = scrollView.contentOffset.x - self.currentOffsetX;
    }
    
    progress = delta / self.bounds.size.width;
    
    if (progress > 1.0) return;
    
    if ([self.delegate respondsToSelector:@selector(pageContentView:originIndex:targetIndex:progress:)]) {
        [self.delegate pageContentView:self originIndex:currentIndex targetIndex:targetIndex progress:progress];
    }
}

#pragma mark - LDPageTitleViewDelegate
//- (void)pageTitleView:(LDPageTitleView *)pageTitleView didSelectedItemAtIndex:(NSInteger)index {
//    
//    NSIndexPath *indePath = [NSIndexPath indexPathForItem:index inSection:0];
//    
//    [self.collectionView scrollToItemAtIndexPath:indePath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    
//}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:LDPageContentViewCollectionViewCellIdentifier];
    }
    return _collectionView;
}

@end
