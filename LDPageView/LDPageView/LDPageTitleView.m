//
//  LDPageTitleView.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDPageTitleView.h"
#import "LDPageContentView.h"
#import "LDPageTitleStyle.h"

@interface LDPageTitleView () 

@end

@implementation LDPageTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleStyle:(LDPageTitleStyle *)titleStyle {
    
    self.titles = titles;
    self.titleStyle = titleStyle;
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self setupScrollView];
    [self setupTitleLabels];
    [self setupTitleLabelsFrame];
    [self setupScrollLine];
    
}

- (void)setupScrollView {
    
    self.scrollView.frame = self.bounds;
    [self addSubview:self.scrollView];
    
}

- (void)setupTitleLabels {
    
    for (int i = 0; i < self.titles.count; i++) {
        
        NSString *title = self.titles[i];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.tag = i;
        titleLabel.text = title;
        titleLabel.font = self.titleStyle.normalFont;
        titleLabel.textColor = (i == self.currentIndex ? self.titleStyle.selectedColor: self.titleStyle.normalColor);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.userInteractionEnabled = YES;
        [self.scrollView addSubview:titleLabel];
        [self.titleLabels addObject:titleLabel];
        
        [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)]];
        
    }
    
}

- (void)setupTitleLabelsFrame {
    
    CGFloat titleLabelX = 0;
    CGFloat titleLabelWidth = self.bounds.size.width / self.titleLabels.count;
    
    UILabel *preLabel = [[UILabel alloc] init];
    
    for (int i = 0; i < self.titleLabels.count; i++) {
        UILabel *titleLabel = self.titleLabels[i];
        
        if (self.titleStyle.isScrollEnable) {
            titleLabelWidth = [titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleStyle.selectedFont} context:nil].size.width;
            
            if (i == 0) {
                titleLabelX = self.titleStyle.margin * 0.5;
            } else {
                titleLabelX = CGRectGetMaxX(preLabel.frame) + self.titleStyle.margin;
            }
        } else {
            
            titleLabelX = i * titleLabelWidth;
            
        }
        
        titleLabel.frame = CGRectMake(titleLabelX, 0, titleLabelWidth, self.bounds.size.height);
        
        preLabel = titleLabel;
    }
    
    if (self.titleStyle.isScrollEnable) {
        
        UILabel *titleLabel = self.titleLabels.lastObject;
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(titleLabel.frame) + self.titleStyle.margin * 0.5, self.bounds.size.height);
        
    } else {
        self.scrollView.contentSize = CGSizeZero;
    }
    
}

- (void)setupScrollLine {
    
    self.scrollLine.hidden = !self.titleStyle.hasScrollLine;
    
    UILabel *selectedLabel = self.titleLabels[self.currentIndex];
    
    self.scrollLine.frame = CGRectMake(CGRectGetMinX(selectedLabel.frame), self.bounds.size.height - self.titleStyle.scrollLineHeight, selectedLabel.frame.size.width, self.titleStyle.scrollLineHeight);
    
    [self.scrollView addSubview:self.scrollLine];
    
}


#pragma mark - Action Mothods
- (void)titleLabelClick:(UITapGestureRecognizer *)tap {
    
    UILabel *tapLabel = (UILabel *)tap.view;
    
    [self changeSelectedLabel:tapLabel];
    
    if ([self.delegate respondsToSelector:@selector(pageTitleView:didSelectedItemAtIndex:)]) {
        [self.delegate pageTitleView:self didSelectedItemAtIndex:tapLabel.tag];
    }
    
}

- (void)changeSelectedLabel:(UILabel *)newLabel {
    
    UILabel *preLabel = self.titleLabels[self.currentIndex];
    
    preLabel.textColor = self.titleStyle.normalColor;
    newLabel.textColor = self.titleStyle.selectedColor;
    
    self.currentIndex = newLabel.tag;
    
    if (self.titleStyle.isScrollEnable) {
        CGFloat offsetX = newLabel.center.x - self.bounds.size.width * 0.5;
        
        if (offsetX < 0) {
            offsetX = 0;
        }
        
        if (offsetX > self.scrollView.contentSize.width - self.bounds.size.width) {
            offsetX = self.scrollView.contentSize.width - self.bounds.size.width;
        }
        
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
        [UIView animateWithDuration:0.25 animations:^{
           
            CGRect scrollLineFrame = self.scrollLine.frame;
            scrollLineFrame.origin.x = newLabel.frame.origin.x;
            scrollLineFrame.size.width = newLabel.frame.size.width;
            self.scrollLine.frame = scrollLineFrame;
            
        }];
        
    } else {
        
        CGRect scrollLineFrame = self.scrollLine.frame;
        scrollLineFrame.origin.x = newLabel.frame.origin.x;
        scrollLineFrame.size.width = newLabel.frame.size.width;
        self.scrollLine.frame = scrollLineFrame;
    }
    
}

- (UIColor *)mixtureColor:(UIColor *)color1 otherColor:(UIColor *)color2 ratio:(CGFloat)ratio {
    
    CGColorRef cgColor1 = color1.CGColor;
    
    CGColorRef cgColor2 = color2.CGColor;
    
    const CGFloat *comps1 = CGColorGetComponents(cgColor1);
    const CGFloat *comps2 = CGColorGetComponents(cgColor2);
    
    if (CGColorGetNumberOfComponents(cgColor1) < 3) {
        @throw [NSException exceptionWithName:@"异常" reason:@"请使用RGB颜色" userInfo:nil];
    }
    
    if (CGColorGetNumberOfComponents(cgColor2) < 3) {
        @throw [NSException exceptionWithName:@"异常" reason:@"请使用RGB颜色" userInfo:nil];
    }
    
    
    
    CGFloat r = comps2[0] * ratio + comps1[0] * (1 - ratio);
    CGFloat g = comps2[1] * ratio + comps1[1] * (1 - ratio);
    CGFloat b = comps2[2] * ratio + comps1[2] * (1 - ratio);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

- (void)changeCurrentIndex:(NSInteger)currentIndex {
    
    UILabel *tapLabel = self.titleLabels[currentIndex];
    
    [self changeSelectedLabel:tapLabel];
    
}


#pragma mark - LDPageContentViewDelegate
- (void)pageContentView:(LDPageContentView *)pageContentView didEndScrollAtindex:(NSInteger)index {
    
    if (self.currentIndex == index) return;
    
    UILabel *newLabel = self.titleLabels[index];
    
    [self changeSelectedLabel:newLabel];
    
}

- (void)pageContentView:(LDPageContentView *)pageContentView originIndex:(NSInteger)originIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress {
    
    UILabel *originLabel = self.titleLabels[originIndex];
    UILabel *targetLabel = self.titleLabels[targetIndex];
    
    if (self.titleStyle.hasGradient) { // 标题文字渐变
        targetLabel.textColor = [self mixtureColor:self.titleStyle.normalColor otherColor:self.titleStyle.selectedColor ratio:progress];
        originLabel.textColor = [self mixtureColor:self.titleStyle.selectedColor otherColor:self.titleStyle.normalColor ratio:progress];
        
        CGFloat fontDelta = self.titleStyle.selectedFont.pointSize - self.titleStyle.normalFont.pointSize;
        targetLabel.font = [UIFont systemFontOfSize:self.titleStyle.normalFont.pointSize - fontDelta * progress];
        originLabel.font = [UIFont systemFontOfSize:self.titleStyle.selectedFont.pointSize - fontDelta * progress];
        
    }
    
    if (self.titleStyle.lineScrollType == kLineScrollTypeRealTime) {
        CGFloat xDelta = CGRectGetMinX(targetLabel.frame) - CGRectGetMinX(originLabel.frame);
        CGFloat wDelta = targetLabel.frame.size.width - originLabel.frame.size.width;
        
        CGRect scrollLineFrame = self.scrollLine.frame;
        scrollLineFrame.origin.x = originLabel.frame.origin.x + xDelta * progress;
        scrollLineFrame.size.width = originLabel.frame.size.width + wDelta * progress;
        
        self.scrollLine.frame = scrollLineFrame;
    }
    
}

#pragma mark - lazy
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)scrollLine {
    if (_scrollLine == nil) {
        _scrollLine = [[UIView alloc] init];
        _scrollLine.backgroundColor = self.titleStyle.scrollLineColor;
    }
    return _scrollLine;
}

- (NSMutableArray *)titleLabels {
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

@end
