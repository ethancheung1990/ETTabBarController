//
//  UITabBar+ETTab.m
//  MyProject
//
//  Created by Ethan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import "UITabBar+ETTab.h"
#import <objc/runtime.h>
#import "ETTabBarButton.h"
#import "ETBadgeView.h"

#import "ETTabBarItem.h"

static const char *__categoryDelegateKey = "categoryDelegate";
static const char *__buttonArrayKey = "buttonArray";

@implementation UITabBar (ETTab)

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setButtons:[NSMutableArray new]];
    }
    return self;
}

- (void)setItems:(NSArray<ETTabBarItem *> *)items tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage *)backgroundImage {
    
    for (UIView *v in self.subviews) {
        if ([v isMemberOfClass:NSClassFromString(@"UITabBarButton")]) {
            [v removeFromSuperview];
        }
    }
    [[self buttons] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[self buttons] removeAllObjects];
    [self setShadowImage:[[UIImage alloc] init]];
    
    self.backgroundImage = backgroundImage;
    
    if (barWidth <= 0) {
        barWidth = self.frame.size.width;
    }
    
    if (items.count == 0) {
        return;
    }
    
    CGFloat widthEach = (barWidth)/(items.count);
    CGFloat offSetX = self.frame.size.width/2 - barWidth/2;
    
    [items enumerateObjectsUsingBlock:^(ETTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ETTabBarButton *button = [[ETTabBarButton alloc] initWithFrame:CGRectMake(idx*widthEach + offSetX, 0, widthEach, self.height)];
        button.item = obj;
        [button addTarget:self action:@selector(_tap:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:button];
        [[self buttons] addObject:button];
        if (idx == 0) {
            button.selected = YES;
        }
    }];
    
}

- (void)setBadgeString:(NSString*)badgeString atIndex:(NSUInteger)index {
    ETTabBarButton *button = [self _buttonAtIndex:index];
    [button setBadgeString:badgeString];
}

- (void)setSelectedIndex:(NSUInteger)index {
    ETTabBarButton *button = [self _buttonAtIndex:index];
    if (button) {
        [[self buttons] enumerateObjectsUsingBlock:^(ETTabBarButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj == button) {
                obj.selected = YES;
            } else {
                obj.selected = NO;
            }
        }];
    }
}

#pragma mark - private

- (ETTabBarButton*)_buttonAtIndex:(NSUInteger)index {
    return [[self buttons] objectOrNilAtIndex:index];
}

#pragma mark - action selector

- (void)_tap:(ETTabBarButton*)sender {
    if ([self.categoryDelegate respondsToSelector:@selector(tabBar:buttonDidClickedAtIndex:)]) {
        [self.categoryDelegate tabBar:self buttonDidClickedAtIndex:[[self buttons] indexOfObject:sender]];
    }
}

#pragma mark - property

- (id<UITabBarButtonDelegate>)categoryDelegate {
    return objc_getAssociatedObject(self, __categoryDelegateKey);
}

- (void)setCategoryDelegate:(id<UITabBarButtonDelegate>)categoryDelegate {
    objc_setAssociatedObject(self, __categoryDelegateKey, categoryDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (void)setButtons:(NSMutableArray<ETTabBarButton*> *)buttons {
    objc_setAssociatedObject(self, __buttonArrayKey, buttons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray<ETTabBarButton*> *)buttons {
    return objc_getAssociatedObject(self, __buttonArrayKey);
}

@end
