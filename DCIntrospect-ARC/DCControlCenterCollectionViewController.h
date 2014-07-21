//
//  DCControlCenterCollectionViewController.h
//  Example
//
//  Created by Mason Silber on 7/18/14.
//  Copyright (c) 2014 Lukas Welte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCControlCenterCollectionView : UICollectionView
@end

@interface DCControlCenterCollectionViewCell : UICollectionViewCell
@end

@interface DCControlCenterCollectionViewCellLabel : UILabel
@end

@interface DCControlCenterCollectionViewController : UIViewController
@property (nonatomic) UICollectionView *collectionView;
@end
