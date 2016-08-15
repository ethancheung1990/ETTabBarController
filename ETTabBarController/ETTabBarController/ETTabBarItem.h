//
//  ETTabBarItem.h
//  MyProject
//
//  Created by Ethan on 16/8/11.
//  Copyright © 2016年 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETTabBarItem : NSObject

@property (nonatomic, strong, nullable) UIViewController *controller;

@property (nonatomic, assign) CGPoint imageOffset;

@property (nonatomic, strong, nullable) UIImage *image;
@property (nonatomic, strong, nullable) UIImage *selectedImage;

@property (nonatomic, strong, nullable) UIColor *titleColor;
@property (nonatomic, strong, nullable) UIColor *selectedTitleColor;

@property (nonatomic, strong, nullable) UIFont *titleFont;
@property (nonatomic, copy, nullable) NSString *title;

/**
 * 起泡文字，可通过item的该属性来设置默认值
 * 也可以通过 ETTabBarController 中的 - (void)setBadgeString:(NSString*)badgeString atIndex:(NSUInteger)index 设置
 * 调用 - (void)setBadgeString:(NSString*)badgeString atIndex:(NSUInteger)index 时，会自动设置item中的该属性
 */
@property (nonatomic, copy, nullable) NSString *badgeString;

/**
 * 当controller为nil时，或当前选中再次点击时调用
 */
@property (nonatomic, copy, nullable) void(^actionBlock)(ETTabBarItem * _Nonnull item);

/**
 * 必须遵循 ETBadgeViewProtocol 协议
 */
@property (nonatomic, strong, nullable) Class badgeViewClass;

@end
