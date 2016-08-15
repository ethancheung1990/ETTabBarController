//
//  ETBadgeView.m
//  MyProject
//
//  Created by Ethan on 14-2-13.
//  Copyright (c) 2014年 ethan. All rights reserved.
//

#import "ETBadgeView.h"

@interface ETBadgeView()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ETBadgeView

@synthesize badgeString = _badgeString;

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.image = [[UIImage imageNamed:@"gen_notice"] stretchableImageWithLeftCapWidth:9.0 topCapHeight:9.0];
        self.backgroundColor = [UIColor clearColor];
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont systemFontOfSize:13.0f];
        self.clipsToBounds = YES;
        [self addSubview:self.label];
    }
    return self;
}

#pragma mark - override

- (void)setBadgeString:(NSString *)badgeString {
    self.image = nil;
    _badgeString = [badgeString copy];
    self.label.text = _badgeString;
    if (_badgeString.length > 0) {
        self.image = [[UIImage imageNamed:@"gen_notice"] stretchableImageWithLeftCapWidth:18/2.0f topCapHeight:18/2.0f];
        [self.label sizeToFit];
        CGFloat maxHeight = self.image.size.height;
        CGFloat maxWidth = MAX(MAX(self.label.width + 8, self.image.size.width), maxHeight);
        self.height = maxHeight;
        self.width = maxWidth;
    } else {
        self.image = [[UIImage imageNamed:@"gen_notice_lil"] stretchableImageWithLeftCapWidth:11/2.0f topCapHeight:11/2.0f];
        self.height = self.image.size.height;
        self.width = self.image.size.width;
        
        self.label.frame = self.bounds;
    }
    self.label.left = self.width/2 - self.label.width/2 + 1;
    self.label.top = self.height/2 - self.label.height/2 - 1;
    self.hidden = _badgeString == nil;
}

- (void)resetFrame {
    UIView *superView = self.superview;
    if (self.badgeString.length) {
        self.origin = CGPointMake(MIN(superView.width/2 + 2, superView.width - self.width - 5), 5);
    } else {
        self.origin = CGPointMake(superView.width + 5, 5);
    }
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
