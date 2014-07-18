//
//  DCControlCenterCollectionViewController.m
//  Example
//
//  Created by Mason Silber on 7/18/14.
//  Copyright (c) 2014 Lukas Welte. All rights reserved.
//

#import "DCControlCenterCollectionViewController.h"

#define KEYS_MATRIX @[@[@"A", @"C", @"f", @"O", @"o", @".", @"?"],\
                      @[@"a", @"p", @"m", @"v", @"W", @"X", @"`"],\
                      @[@"y", @"t", @"5", @"0", @"d", @"l", @"r"],\
                      @[@"+", @"-", @"Alt", @"↑", @"↓", @"←", @"→"]]

@interface DCControlCenterCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@end

@implementation DCControlCenterCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.bounds), floorf(CGRectGetHeight(self.view.bounds)/2.0f)) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];

    CGRect viewFrame = self.collectionView.frame;
    viewFrame.origin.y = floorf(CGRectGetHeight(self.view.bounds)/2.0f);
    self.view = [[UIView alloc] initWithFrame:viewFrame];
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [KEYS_MATRIX count] * [KEYS_MATRIX[0] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];

    cell.backgroundColor = [UIColor blackColor];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 1.0f;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(44, 44);
}

@end
