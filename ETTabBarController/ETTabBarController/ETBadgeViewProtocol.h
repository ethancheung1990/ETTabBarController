//
//  ETBadgeViewProtocol.h
//  MyProject
//
//  Created by Ethan on 16/8/11.
//  Copyright © 2016年 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * TabBar中的BadgeView协议
 */
@protocol ETBadgeViewProtocol <NSObject>

/**
 * 设置和读取badgeString，需要实现badgeString的显示和BadgeView本身的hidden控制
 */
@property (nonatomic, copy) NSString *badgeString;

/**
 * 设置badgeString之后，frame的变化
 */
- (void)resetFrame;

@end
