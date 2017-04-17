//
//  LDPageTitleStyle.h
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    
    kLineScrollTypeDidEndChange, /// 标题文字改变完成时滚动
    kLineScrollTypeRealTime /// 实时滚动
    
} kLineScrollType;


@interface LDPageTitleStyle : NSObject

/** 标题视图高度 */
@property (nonatomic, assign) CGFloat titleViewHeight;

/** 标题间距 */
@property (nonatomic, assign) CGFloat margin;

/** 标题字体大小 */
@property (nonatomic, strong) UIFont *normalFont;

/** 选中标题字体大小 */
@property (nonatomic, strong) UIFont *selectedFont;

/** 未选中字体颜色 */
@property (nonatomic, strong) UIColor *normalColor;

/** 选中字体颜色 .orange */
@property (nonatomic, strong) UIColor *selectedColor;

/** 标题视图是否可以滚动  当不能滚动时，则标题是等宽的 */
@property (nonatomic, assign) BOOL isScrollEnable;

/** 是否有随选中标题滚动的下划线 */
@property (nonatomic, assign) BOOL hasScrollLine;

/** 滚动条滚动类型 */
@property (nonatomic, assign) kLineScrollType lineScrollType;

/** 下划线高度 */
@property (nonatomic, assign) CGFloat scrollLineHeight;

/** 下划线颜色 .orange */
@property (nonatomic, strong) UIColor *scrollLineColor;

/** 标题文字是否有渐变的效果 */
@property (nonatomic, assign) BOOL hasGradient;

@end
