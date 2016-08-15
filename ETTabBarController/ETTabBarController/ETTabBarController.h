//
//  TabBarController.h
//  MyProject
//
//  Created by Ethan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTabBarItem.h"

@protocol ETTabBarControllerDelegate;

@interface ETTabBarController : UITabBarController

/**
 * 可单独设置该属性来更新 ETTabBarController 的viewcontrllers和tabbar的 图标、文字、起泡等信息
 */
@property (nonatomic, copy) NSArray<ETTabBarItem*> *items;

/**
 * 在TabBarController的viewControllers中的ViewController在设置title时，需要使用navigationItems.title设置
 * 直接设置title会导致tabbar中出现界面错误
 * 若有其他方法避免，欢迎指正
 */
- (id)initWithBarItems:(NSArray<ETTabBarItem*>*)items tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)backgroundImage;

- (void)setBadgeString:(NSString*)badgeString atIndex:(NSUInteger)index;

@end