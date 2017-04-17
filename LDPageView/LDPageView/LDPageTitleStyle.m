//
//  LDPageTitleStyle.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDPageTitleStyle.h"

@implementation LDPageTitleStyle

- (instancetype)init {
    
    if (self = [super init]) {
        _titleViewHeight = 40;
        _margin = 16;
        _normalFont = [UIFont systemFontOfSize:14];
        _selectedFont = _normalFont;
        _normalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        _selectedColor = [UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0];
        _isScrollEnable = YES;
        _hasScrollLine = NO;
        _lineScrollType = kLineScrollTypeDidEndChange;
        _scrollLineHeight = 2;
        _scrollLineColor = _selectedColor;
        _hasGradient = NO;
    }
    return self;
}

@end
