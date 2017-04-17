//
//  LDPageView.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDPageView.h"

@interface LDPageView () <LDPageTitleViewDelegate>

@end

@implementation LDPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles childViewControllers:(NSArray<UIViewController *> *)childViewControllers parentViewController:(UIViewController *)parentViewController titleStyle:(LDPageTitleStyle *)titleStyle {
    
    self.titles = titles;
    self.childViewControllers = childViewControllers;
    self.parentViewController = parentViewController;
    self.titleStyle = titleStyle;
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self setupChildViewControllers];
    [self setupTitleView];
    [self setupContentView];
    [self setupLink];
    
}

- (void)setupChildViewControllers {
    
    for (UIViewController *vc in self.childViewControllers) {
        [self.parentViewController addChildViewController:vc];
    }
    
}

- (void)setupTitleView {
    self.titleView = [[LDPageTitleView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.titleStyle.titleViewHeight) titles:self.titles titleStyle:self.titleStyle];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleView];
}

- (void)setupContentView {
    
    self.contentView = [[LDPageContentView alloc] initWithFrame:CGRectMake(0, self.titleView.frame.size.height, self.bounds.size.width, self.bounds.size.height - self.titleView.frame.size.height) childViewControllers:self.childViewControllers];
    [self addSubview:self.contentView];
    
}

- (void)setupLink {
    self.titleView.delegate = self;
    self.contentView.delegate = self.titleView;
}


#pragma mark - LDPageTitleViewDelegate
- (void)pageTitleView:(LDPageTitleView *)pageTitleView didSelectedItemAtIndex:(NSInteger)index {
    
    NSIndexPath *indePath = [NSIndexPath indexPathForItem:index inSection:0];
    
    [self.contentView.collectionView scrollToItemAtIndexPath:indePath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}

@end
