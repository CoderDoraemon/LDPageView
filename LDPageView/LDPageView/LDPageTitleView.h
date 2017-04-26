//
//  LDPageTitleView.h
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDPageContentView.h"

@class LDPageTitleView, LDPageTitleStyle;

@protocol LDPageTitleViewDelegate <NSObject>

@optional
- (void)pageTitleView:(LDPageTitleView *)pageTitleView didSelectedItemAtIndex:(NSInteger)index;

@end


@interface LDPageTitleView : UIView <LDPageContentViewDelegate>

/** 代理 */
@property (nonatomic, weak) id<LDPageTitleViewDelegate> delegate;

/** 样式 */
@property (nonatomic, strong) LDPageTitleStyle *titleStyle;

/** 标题数组 */
@property (nonatomic, strong) NSArray *titles;

/** <#Description#> */
@property (nonatomic, strong) UIScrollView *scrollView;

/** <#Description#> */
@property (nonatomic, assign) NSInteger currentIndex;

/** 下滑线 */
@property (nonatomic, strong) UIView *scrollLine;

/** 标题label数组 */
@property (nonatomic, strong) NSMutableArray *titleLabels;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleStyle:(LDPageTitleStyle *)titleStyle;

- (void)changeCurrentIndex:(NSInteger)currentIndex;

@end
