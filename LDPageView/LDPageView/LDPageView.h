//
//  LDPageView.h
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDPageTitleStyle.h"
#import "LDPageContentView.h"
#import "LDPageTitleView.h"

@interface LDPageView : UIView

/** 标题名称数组 */
@property (nonatomic, strong) NSArray<NSString *> *titles;

/** 子控制器数组 */
@property (nonatomic, strong) NSArray<UIViewController *> *childViewControllers;

/** 样式 */
@property (nonatomic, strong) LDPageTitleStyle *titleStyle;

/** 容器 */
@property (nonatomic, strong) LDPageTitleView *titleView;

/** 容器 */
@property (nonatomic, strong) LDPageContentView *contentView;

/** parentViewController */
@property (nonatomic, strong) UIViewController *parentViewController;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles childViewControllers:(NSArray<UIViewController *> *)childViewControllers parentViewController:(UIViewController *)parentViewController titleStyle:(LDPageTitleStyle *)titleStyle;

@end
