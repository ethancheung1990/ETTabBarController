//
//  ETTabButton.m
//  MyProject
//
//  Created by Ethan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import "ETTabBarButton.h"
#import "ETTabBarItem.h"
#import "ETBadgeViewProtocol.h"
#import "ETBadgeView.h"

#define DEFAULT_FONT [UIFont boldSystemFontOfSize:12]

@interface ETTabBarButton()

@property (nonatomic, strong) UIView<ETBadgeViewProtocol> *badgeView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ETTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.imageView = [UIImageView new];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = DEFAULT_FONT;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

- (void)setBadgeString:(NSString *)badgeString {
    self.badgeView.badgeString = badgeString;
    self.item.badgeString = badgeString;
    [self.badgeView resetFrame];
}

#pragma mark - private

- (void)_refreshSubviewsState {
    BOOL isHighlighted = self.isHighlighted || self.isSelected;
    BOOL changed = NO;
    if (self.titleLabel.isHighlighted != isHighlighted) {
        self.titleLabel.highlighted = isHighlighted;
        changed = YES;
    }
    if (self.imageView.isHighlighted != isHighlighted) {
        self.imageView.highlighted = isHighlighted;
        changed = YES;
    }
    if (changed) {
        [self setNeedsLayout];
    }
}

- (void)_refresh {
    self.imageView.image = _item.image;
    self.imageView.highlightedImage = _item.selectedImage;
    self.titleLabel.textColor = _item.titleColor;
    self.titleLabel.highlightedTextColor = _item.selectedTitleColor;
    self.titleLabel.font = _item.titleFont ? : DEFAULT_FONT;
    self.titleLabel.text = _item.title;
    
    Class badgeViewClass = _item.badgeViewClass ? : [ETBadgeView class];
    if ([badgeViewClass conformsToProtocol:@protocol(ETBadgeViewProtocol)]) {
        [self.badgeView removeFromSuperview];
        self.badgeView = [[badgeViewClass alloc] init];
        self.badgeView.userInteractionEnabled = NO;
        [self addSubview:self.badgeView];
        self.badgeView.badgeString = _item.badgeString;
    }

    [self setNeedsLayout];
}

#pragma mark - getter and setter

- (void)setItem:(ETTabBarItem *)item {
    _item = item;
    [self _refresh];
}

#pragma mark - override

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel sizeToFitWithSize:CGSizeMake(self.width - 3*2, 20)];
    self.titleLabel.center = CGPointMake(self.width/2, self.height - 3 - self.titleLabel.height/2);
    [self.imageView sizeToFit];
    self.imageView.center = CGPointMake(self.width/2 + self.item.imageOffset.x, self.height/2 - self.titleLabel.height/2 + self.item.imageOffset.y);
    [self.badgeView resetFrame];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self _refreshSubviewsState];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self _refreshSubviewsState];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
