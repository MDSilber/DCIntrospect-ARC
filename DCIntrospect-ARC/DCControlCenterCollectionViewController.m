//
//  DCControlCenterCollectionViewController.m
//  Example
//
//  Created by Mason Silber on 7/18/14.
//  Copyright (c) 2014 Lukas Welte. All rights reserved.
//

#import "DCControlCenterCollectionViewController.h"
#import "DCIntrospect.h"

#define KEYS_MATRIX @[@[@"A", @"C", @"f", @"O", @"o", @".", @"?"],\
                      @[@"a", @"p", @"m", @"v", @"W", @"X", @"`"],\
                      @[@"y", @"t", @"5", @"0", @"d", @"l", @"r"],\
                      @[@"+", @"-", @"Alt", @"↑", @"↓", @"←", @"→"]]

@implementation DCControlCenterCollectionView
@end

@implementation DCControlCenterCollectionViewCell
@end

@implementation DCControlCenterCollectionViewCellLabel
@end

@interface DCControlCenterCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@end

@implementation DCControlCenterCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[DCControlCenterCollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.bounds), 200.0f) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[DCControlCenterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DCControlCenterCollectionViewCell class])];

    CGRect viewFrame = self.collectionView.frame;
    viewFrame.origin.y = CGRectGetHeight(self.view.bounds) - 200.0f;
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
    DCControlCenterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DCControlCenterCollectionViewCell class]) forIndexPath:indexPath];

    cell.contentView.backgroundColor = [UIColor darkGrayColor];
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 1.0f;
    
    DCControlCenterCollectionViewCellLabel *letterLabel = [[DCControlCenterCollectionViewCellLabel alloc] init];
    letterLabel.backgroundColor = [UIColor clearColor];
    letterLabel.textColor = [UIColor whiteColor];
    letterLabel.text = [self _stringForIndexPath:indexPath];
    [letterLabel sizeToFit];
    letterLabel.center = cell.contentView.center;

    [cell.contentView addSubview:letterLabel];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(40, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 4.0f;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView cellForItemAtIndexPath:indexPath].contentView.backgroundColor = [UIColor lightGrayColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView cellForItemAtIndexPath:indexPath].contentView.backgroundColor = [UIColor darkGrayColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if ([[self _stringForIndexPath:indexPath] isEqualToString:@"Alt"]) {
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    } else {
        cell.contentView.backgroundColor = [UIColor darkGrayColor];
        cell.selected = NO;
    }
    
    NSString *keyString = [self _stringForIndexPath:indexPath];
    if ([keyString isEqualToString:@"↑"]) {
        keyString = @"8";
    } else if ([keyString isEqualToString:@"↓"]) {
        keyString = @"2";
    } else if ([keyString isEqualToString:@"←"]) {
        keyString = @"4";
    } else if ([keyString isEqualToString:@"→"]) {
        keyString = @"6";
    }

    [[DCIntrospect sharedIntrospector] handleKeyPressForString:keyString];
}

- (NSString *)_stringForIndexPath:(NSIndexPath *)indexPath
{
    return KEYS_MATRIX[indexPath.item / 7][indexPath.row % 7];
}
@end
