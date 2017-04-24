//
//  LDViewController.m
//  LDPageView
//
//  Created by 文刂Rn on 2017/4/17.
//  Copyright © 2017年 文刂Rn. All rights reserved.
//

#import "LDViewController.h"
#import "LDCollectionViewLayout.h"

static NSString *const kUICollectionViewCellIdentifier = @"kUICollectionViewCellIdentifier";

@interface LDViewController () <UICollectionViewDelegate, UICollectionViewDataSource, LDCollectionViewLayoutDelegate>

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation LDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setup];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}


- (void)setup {
    
    
    
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUICollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}


#pragma mark - LDCollectionViewLayoutDelegate
- (CGFloat)ld_collectionView:(UICollectionView *)collectionView layout:(LDCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath widthForItem:(CGFloat)width {
    
    return arc4random_uniform(150) + 100;
    
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        
//        layout.itemSize = CGSizeMake(100, 100);
//        layout.minimumLineSpacing = 10;
//        layout.minimumInteritemSpacing = 10;
        
        
        LDCollectionViewLayout *layout = [[LDCollectionViewLayout alloc] init];
        layout.delegate = self;
        layout.columnNumber = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kUICollectionViewCellIdentifier];
    }
    return _collectionView;
    
}

@end
