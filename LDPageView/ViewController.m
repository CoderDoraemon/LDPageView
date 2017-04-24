//
//  ViewController.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "ViewController.h"

#import "LDViewController.h"

#import "LDPageView.h"

@interface ViewController ()

/** <#Description#> */
@property (nonatomic, strong) LDPageView *pageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"PageView";
    
    
    NSArray *titles = @[@"推荐", @"头条", @"军事", @"段子", @"哈哈哈", @"段子", @"轻松一刻", @"哈哈"];
    NSMutableArray *tempTitles = [NSMutableArray array];
    for (int i = 0 ; i < titles.count; i++) {
        LDViewController *vc = [[LDViewController alloc] init];
//        vc.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        vc.titleString = titles[i];
        
        [tempTitles addObject:vc];
    }
    
    LDPageTitleStyle *titleStyle = [[LDPageTitleStyle alloc] init];
    
    
    //        titleStyle.isScrollEnable = false
    // 样式一
    titleStyle.hasScrollLine = YES;
    
    // 样式二
    //        titleStyle.hasScrollLine = true
    //        titleStyle.lineScrollType = .RealTime
    
    // 样式三
    titleStyle.hasGradient = NO;
    //        titleStyle.selectedColor = UIColor(red: 1.0, green: 0.5, blue: 0, alpha: 1.0)
    
    // 样式四
    //        titleStyle.hasGradient = true
    //        titleStyle.selectedFont = UIFont.systemFont(ofSize: 16)
    
    // titles：标题数组
    // childVCs：每个标题对应要显示的控制器
    // parentVC：标题控制器对应的父控制器
    // titleStyle： 控制器标题的样式
    LDPageView *pageView = [[LDPageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 49) titles:titles childViewControllers:tempTitles parentViewController:self titleStyle:titleStyle];
    [self.view addSubview:pageView];
    
    self.pageView = pageView;
    
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}


@end
