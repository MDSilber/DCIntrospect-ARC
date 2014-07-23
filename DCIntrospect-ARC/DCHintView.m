//
//  DCHintView.m
//  Example
//
//  Created by Mason Silber on 7/23/14.
//  Copyright (c) 2014 Lukas Welte. All rights reserved.
//

#import "DCHintView.h"

@interface DCHintView ()
@property (nonatomic) UILabel *hintLabel;
@end

@implementation DCHintView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.backgroundColor = [UIColor blackColor];
        _hintLabel.textColor = [UIColor whiteColor];
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _hintLabel.numberOfLines = 1;
        _hintLabel.font = [UIFont systemFontOfSize:12.0f];

        [self addSubview:_hintLabel];
    }
    return self;
}

- (void)setHint:(NSString *)hint
{
    if (_hint != hint) {
        _hint = hint;
        self.hintLabel.text = hint;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];    
    CGSize hintSize = [self.hintLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds) - 20.0f, 20.0f) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : self.hintLabel.font} context:nil].size;
    
    self.hintLabel.frame = CGRectMake(0.0f, 0.0f, hintSize.width, hintSize.height);
    self.hintLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

@end
