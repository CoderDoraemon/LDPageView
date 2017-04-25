//
//  LDOtherViewController.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/25.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDOtherViewController.h"
#import "LDPageCollectionView.h"

static NSString *const kLDPageCollectionViewID = @"kLDPageCollectionViewID";

@interface LDOtherViewController () <LDPageCollectionViewDataSource>

@end

@implementation LDOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setup];
}


- (void)setup {
    
//    self.navigationController.navigationBar.translucent = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"PageCollectionView";
    
    
    NSArray *titles = @[@"推荐", @"头条", @"军事", @"段子"];
    
    LDPageTitleStyle *titleStyle = [[LDPageTitleStyle alloc] init];
    
    
    titleStyle.isScrollEnable = NO;
    // 样式一
    titleStyle.hasScrollLine = YES;
    
    LDPageCollectionView *pageCollectionView = [[LDPageCollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 300) titles:titles style:titleStyle];
    
    [pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kLDPageCollectionViewID];
    
    pageCollectionView.dataSource = self;
    
    
    [self.view addSubview:pageCollectionView];
}


#pragma mark - LDPageCollectionViewDataSource
- (NSInteger)numberOfSectionsInPageCollectionView:(LDPageCollectionView *)pageCollectionView {
    return 4;
}

- (NSInteger)pageCollectionView:(LDPageCollectionView *)pageCollectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}


- (UICollectionViewCell *)pageCollectionView:(LDPageCollectionView *)pageCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [pageCollectionView dequeueReusableCellWithReuseIdentifier:kLDPageCollectionViewID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    return cell;
}


@end
