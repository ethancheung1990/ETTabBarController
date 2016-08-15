//
//  TabBarController.m
//  MyProject
//
//  Created by Ethan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import "ETTabBarController.h"
#import "UITabBar+ETTab.h"
#import "ETTabBarButton.h"

#import "ETTabBarItem.h"

@interface ETTabBarController()<UITabBarButtonDelegate>

@property (nonatomic, assign) CGFloat barWidth;
@property (nonatomic, strong) UIImage *backgroundImage;

@end

@implementation ETTabBarController

- (id)initWithBarItems:(NSArray<ETTabBarItem *> *)items tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage *)backgroundImage {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.barWidth = barWidth;
        self.backgroundImage = backgroundImage;
        self.items = items;
        self.tabBar.categoryDelegate = self;
        
    }
    return self;
}

- (void)setBadgeString:(NSString *)badgeString atIndex:(NSUInteger)index {
    [self.tabBar setBadgeString:badgeString atIndex:index];
}

#pragma mark - private

- (void)_selectTabBarWithIndex:(NSUInteger)index performAction:(BOOL)perform {
    ETTabBarItem *item = [self.items objectOrNilAtIndex:index];
    if (item.controller) {
        NSUInteger controllerIndex = [self.viewControllers indexOfObject:item.controller];
        if (controllerIndex != NSNotFound) {
            [self.tabBar setSelectedIndex:index];
            if (controllerIndex != [super selectedIndex]) {
                [super setSelectedIndex:controllerIndex];
            } else if (perform && item.actionBlock) {
                item.actionBlock(item);
            }
        }
        
    } else if (perform && item.actionBlock) {
        item.actionBlock(item);
    }
}

#pragma mark - getter and setter

- (void)setItems:(NSArray<ETTabBarItem *> *)items {
    
    NSMutableArray *vcs = [NSMutableArray new];
    __block NSUInteger nowButtonIndex = NSNotFound;
    [items enumerateObjectsUsingBlock:^(ETTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [vcs addObjectIfNotNil:obj.controller];
        if (self.selectedViewController && obj.controller == self.selectedViewController) {
            nowButtonIndex = idx;
        }
    }];
    if (nowButtonIndex == NSNotFound) {
        nowButtonIndex = 0;
    }
    
    /*
     * 因为 setViewController 会调用 setSelectedIndex 方法
     * 但是在这个时候我们不能让setSelectedIndex调用生效
     * 所以现将_items置为nil
     */
    _items = nil;
    [self setViewControllers:vcs];
    _items = [items copy];
    [self.tabBar setItems:_items tabBarWidth:self.barWidth backgroundImage:self.backgroundImage];
    
    [self _selectTabBarWithIndex:nowButtonIndex performAction:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self _selectTabBarWithIndex:selectedIndex performAction:YES];
}

- (NSUInteger)selectedIndex {
    __block NSUInteger itemIndex = NSNotFound;
    [self.items enumerateObjectsUsingBlock:^(ETTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selectedViewController && obj.controller == self.selectedViewController) {
            itemIndex = idx;
            *stop = YES;
        }
    }];
    if (itemIndex != NSNotFound) {
        return itemIndex;
    }
    return [super selectedIndex];
}

#pragma mark - categoryDelegate

- (void)tabBar:(UITabBar *)tabBar buttonDidClickedAtIndex:(NSUInteger)index {
    
    BOOL shouldSelect = YES;
    ETTabBarItem *item = [self.items objectOrNilAtIndex:index];
    if (item.controller && [self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        shouldSelect = [self.delegate tabBarController:self shouldSelectViewController:item.controller];
    }
    if (shouldSelect) {
        self.selectedIndex = index;
    }
}

#pragma mark - override

- (BOOL)shouldAutorotate {
    return NO;
}


@end
