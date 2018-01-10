//
//  AppDelegate+FCSetup.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/11/18.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "AppDelegate.h"
#import <CYLTabBarController.h>

@interface AppDelegate (FCSetup) <CYLTabBarControllerDelegate>

/**
 * app框架初始化
 */
- (void)setUpAppFrameWorks;

@end
