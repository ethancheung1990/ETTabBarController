//
//  UITabBar+ETTab.h
//  MyProject
//
//  Created by Ethan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETTabBarButton;
@class ETTabBarItem;

@protocol UITabBarButtonDelegate;

@interface UITabBar (ETTab)

@property (nonatomic, weak) id<UITabBarButtonDelegate> categoryDelegate;

- (void)setItems:(NSArray<ETTabBarItem*>*)items tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)backgroundImage;

- (void)setBadgeString:(NSString*)badgeString atIndex:(NSUInteger)index;

- (void)setSelectedIndex:(NSUInteger)index;

@end

@protocol UITabBarButtonDelegate <NSObject>

@optional

- (void)tabBar:(UITabBar*) tabBar buttonDidClickedAtIndex:(NSUInteger)index;

@end
