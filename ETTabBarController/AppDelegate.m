//
//  AppDelegate.m
//  ETTabBarController
//
//  Created by Ethan on 16/8/15.
//  Copyright © 2016年 ethan. All rights reserved.
//

#import "AppDelegate.h"
#import "ETTabBarController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ETTabBarItem *item0 = [[ETTabBarItem alloc] init];
    UIViewController *vc0 = [UIViewController new];
    vc0.navigationItem.title = @"HOME";
    vc0.view.backgroundColor = [UIColor randomColor];
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:vc0];
    item0.controller = nav0;
    [self configItems:item0 title:@"HOME" image:[UIImage imageNamed:@"tab_home"] selectedImage:[UIImage imageNamed:@"tab_home_p"]];
    item0.actionBlock = ^(ETTabBarItem *it) {
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"this is %@", it.title] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    };
    
    ETTabBarItem *item1 = [[ETTabBarItem alloc] init];
    UIViewController *vc1 = [UIViewController new];
    vc1.navigationItem.title = @"MESSAGE";
    vc1.view.backgroundColor = [UIColor randomColor];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    item1.controller = nav1;
    [self configItems:item1 title:@"MESSAGE" image:[UIImage imageNamed:@"tab_msg"] selectedImage:[UIImage imageNamed:@"tab_msg_p"]];

    
    ETTabBarItem *item2 = [[ETTabBarItem alloc] init];
    [self configItems:item2 title:@"CAMERA" image:[UIImage imageNamed:@"tab_camera"] selectedImage:[UIImage imageNamed:@"tab_camera_p"]];
    item2.actionBlock = ^(ETTabBarItem *it) {
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"this is %@", it.title] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    };
    
    ETTabBarItem *item3 = [[ETTabBarItem alloc] init];
    UIViewController *vc3 = [UIViewController new];
    vc3.navigationItem.title = @"WALLET";
    vc3.view.backgroundColor = [UIColor randomColor];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    item3.controller = nav3;
    [self configItems:item3 title:@"WALLET" image:[UIImage imageNamed:@"tab_wallet"] selectedImage:[UIImage imageNamed:@"tab_wallet_p"]];
    
    ETTabBarItem *item4 = [[ETTabBarItem alloc] init];
    UIViewController *vc4 = [UIViewController new];
    vc4.navigationItem.title = @"ME";
    vc4.view.backgroundColor = [UIColor randomColor];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    item4.controller = nav4;
    [self configItems:item4 title:@"ME" image:[UIImage imageNamed:@"tab_me"] selectedImage:[UIImage imageNamed:@"tab_me_p"]];
    item4.actionBlock = ^(ETTabBarItem *it) {
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"this is %@", it.title] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    };
    
    ETTabBarController *tab = [[ETTabBarController alloc] initWithBarItems:@[item0, item1, item2, item3, item4] tabBarWidth:0 backgroundImage:[UIImage imageNamed:@"tab_bg"]];
    tab.delegate = self;
    [tab setSelectedIndex:1];
    [tab setBadgeString:@"12" atIndex:2];
    item0.title = @"NEW0";
    item1.title = @"NEW1";
    item2.title = @"NEW2";
    item3.title = @"NEW3";
    item3.badgeString = @"99+";
    item4.title = @"NEW4";
    item0.controller = [UIViewController new];
    
    self.window.rootViewController = tab;
    
    [self.window makeKeyAndVisible];
    
    [tab setItems:@[item3, item4, item0, item2, item1]];
    
    return YES;
}

- (void)configItems:(ETTabBarItem*)item title:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage {
    item.title = title;
    item.image = image;
    item.selectedImage = selectedImage;
    item.titleColor = [UIColor colorWithHexString:@"898989"];
    item.selectedTitleColor = [UIColor colorWithHexString:@"fb3174"];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
