//
//  LDPageContentView.h
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDPageContentView, LDPageTitleView;

@protocol LDPageContentViewDelegate <NSObject>

@optional
- (void)pageContentView:(LDPageContentView *)pageContentView didEndScrollAtindex:(NSInteger)index;

- (void)pageContentView:(LDPageContentView *)pageContentView originIndex:(NSInteger)originIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;

@end

@interface LDPageContentView : UIView

/** 代理 */
@property (nonatomic, weak) id<LDPageContentViewDelegate> delegate;

/** childViewControllers */
@property (nonatomic, strong) NSArray *childViewControllers;

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** currentOffsetX */
@property (nonatomic, assign) CGFloat currentOffsetX;

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray<UIViewController *> *)childViewControllers;

@end
