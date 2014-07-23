//
//  DCControlCenterCollectionViewController.m
//  Example
//
//  Created by Mason Silber on 7/18/14.
//  Copyright (c) 2014 Lukas Welte. All rights reserved.
//

#import "DCControlCenterCollectionViewController.h"
#import "DCIntrospect.h"
#import "DCHintView.h"

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
@property (nonatomic) BOOL altTriggered;
@property (nonatomic) UIView *explanationView;
@property (nonatomic) DCHintView *hintView;
@end

@implementation DCControlCenterCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[DCControlCenterCollectionView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, CGRectGetWidth(self.view.bounds), 200.0f) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[DCControlCenterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DCControlCenterCollectionViewCell class])];
    
    _hintView = [[DCHintView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.bounds), 20.0f)];
    _hintView.hidden = YES;

    CGRect viewFrame = self.collectionView.frame;
    viewFrame.origin.y = CGRectGetHeight(self.view.bounds) - 220.0f;
    viewFrame.size.height = 220.0f;

    self.view = [[UIView alloc] initWithFrame:viewFrame];
    [self.view addSubview:_hintView];
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
    
    NSString *hint = [DCIntrospect commandsAndDescriptions][[self _stringForIndexPath:indexPath]];
    if ([hint length]) {
        self.hintView.hint = hint;
        self.hintView.hidden = NO;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView cellForItemAtIndexPath:indexPath].contentView.backgroundColor = [UIColor darkGrayColor];
    self.hintView.hidden = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if ([[self _stringForIndexPath:indexPath] isEqualToString:@"Alt"] && !self.altTriggered) {
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        self.altTriggered = YES;
    } else {
        cell.contentView.backgroundColor = [UIColor darkGrayColor];
        cell.selected = NO;
        self.altTriggered = NO;
    }

    [[DCIntrospect sharedIntrospector] handleKeyPressForString:[self _stringForIndexPath:indexPath]];
}

- (NSString *)_stringForIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyString = KEYS_MATRIX[indexPath.item / 7][indexPath.row % 7];
    
    if ([keyString isEqualToString:@"↑"]) {
        keyString = (self.altTriggered) ? @"1" : @"8";
    } else if ([keyString isEqualToString:@"↓"]) {
        keyString = (self.altTriggered) ? @"3" : @"2";
    } else if ([keyString isEqualToString:@"←"]) {
        keyString = (self.altTriggered) ? @"7" : @"4";
    } else if ([keyString isEqualToString:@"→"]) {
        keyString = (self.altTriggered) ? @"9" : @"6";
    }
    
    return keyString;
}
@end
