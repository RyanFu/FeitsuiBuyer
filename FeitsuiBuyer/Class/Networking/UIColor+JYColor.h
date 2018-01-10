//
//  UIColor+JYColor.h
//  FaceFood
//
//  Created by JourneyYoung on 2017/12/2.
//  Copyright © 2017年 JY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JYColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
