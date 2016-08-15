//
//  ETTabButton.h
//  MyProject
//
//  Created by Ethan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETTabBarItem;

@interface ETTabBarButton : UIControl

@property (nonatomic, strong) ETTabBarItem *item;

- (void)setBadgeString:(NSString *)badgeString;

@end