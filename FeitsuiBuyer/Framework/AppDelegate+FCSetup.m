//
//  AppDelegate+FCSetup.m
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/11/18.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "AppDelegate+FCSetup.h"
#import <RTRootNavigationController.h>
#import "FCProfileViewController.h"
#import "FCSellerViewController.h"
#import "FCMessageViewController.h"
#import "FCHomeViewController.h"
#import "FCLoginViewController.h"

@implementation AppDelegate (FCSetup)


/**
 * app框架初始化
 */
- (void)setUpAppFrameWorks{
    [self setUpNavigationController];
//    [self setUpTabbarController];
}

/**
 * 初始化导航栏
 */
- (void)setUpNavigationController {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self setUpTabbarController];
    [self.window makeKeyWindow];
}


/**
 * 初始化tabbar
 */
- (CYLTabBarController *)setUpTabbarController {
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    //主页
    FCHomeViewController *homeViewController = [[FCHomeViewController alloc] init];
    RTRootNavigationController *homeNavigationController = [[RTRootNavigationController alloc] initWithRootViewController:homeViewController];
    homeNavigationController.hidesBottomBarWhenPushed = YES;
    //消息
    FCMessageViewController *messageViewController = [[FCMessageViewController alloc] init];
    RTRootNavigationController *messageNavigationController = [[RTRootNavigationController alloc] initWithRootViewController:messageViewController];
    messageNavigationController.hidesBottomBarWhenPushed = YES;
    
    //个人中心 (用户)
    FCProfileViewController *profileViewController = [[FCProfileViewController alloc] init];
    RTRootNavigationController *profileNavigationController = [[RTRootNavigationController alloc] initWithRootViewController:profileViewController];
    profileNavigationController.hidesBottomBarWhenPushed = YES;
    
    //个人中心 (商户)
    FCSellerViewController *sellerViewController = [[FCSellerViewController alloc] init];
    RTRootNavigationController *sellerNavigationController = [[RTRootNavigationController alloc] initWithRootViewController:sellerViewController];
    sellerNavigationController.hidesBottomBarWhenPushed = YES;
    
    
    [self customizeTabBarForController:tabBarController];
    
    tabBarController.delegate = self;
    tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    tabBarController.tabBar.translucent = NO;
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:@[
                                                                homeNavigationController,
                                                                messageNavigationController,
                                                                profileNavigationController
                                                                ]];
    [tabBarController setViewControllers:vcArray];
    return tabBarController;
}


/**
 设置tabBar的属性
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    NSDictionary *homeDict = @{
                               CYLTabBarItemTitle:@"首页",
                               CYLTabBarItemImage:@"首页",
                               CYLTabBarItemSelectedImage:@""
                               };
    NSDictionary *messageDict = @{
                                  CYLTabBarItemTitle:@"消息",
                                  CYLTabBarItemImage:@"消息",
                                  CYLTabBarItemSelectedImage:@""
                                  };
    NSDictionary *profileDict = @{
                                  CYLTabBarItemTitle:@"我的",
                                  CYLTabBarItemImage:@"我的",
                                  CYLTabBarItemSelectedImage:@""
                                  };
    NSDictionary *sellerDict = @{
                                  CYLTabBarItemTitle:@"我的2",
                                  CYLTabBarItemImage:@"我的",
                                  CYLTabBarItemSelectedImage:@""
                                  };
    
    NSArray *tabBarItemAttributes = @[homeDict, messageDict, profileDict];
    tabBarController.tabBarItemsAttributes = tabBarItemAttributes;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView = [control cyl_tabImageView];
    [self addScaleAnimationOnView:animationView repeatCount:1];
}

/**
 * 缩放动画
 */
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@0.7,@1.0];
    animation.duration = 0.3;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

@end
