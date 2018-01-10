//
//  FCUserDefaults.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2018/1/5.
//  Copyright © 2018年 JourneyYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger kIsLogin     = 1;
static const NSInteger kToken       = 2;
static const NSInteger kLoginDate   = 3;
static const NSInteger kIsCategory  = 4;

@interface FCUserDefaults : NSObject

+ (BOOL)saveIntger:(NSInteger)value forKey:(NSInteger)key;

+ (BOOL)saveBool:(BOOL)value forKey:(NSInteger)key;

+ (BOOL)saveObject:(id)value forKey:(NSInteger)key;

+ (id)objectForKey:(NSInteger)key;

+ (NSInteger)intgerForKey:(NSInteger)key;

+ (BOOL)boolForKey:(NSInteger)key;
@end
