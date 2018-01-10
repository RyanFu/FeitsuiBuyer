//
//  FCUserDefaults.m
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2018/1/5.
//  Copyright © 2018年 JourneyYoung. All rights reserved.
//

#import "FCUserDefaults.h"

@interface FCUserDefaults()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation FCUserDefaults

+(instancetype)shareManager{
    static FCUserDefaults *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [FCUserDefaults new];
        sharedManager.defaults = [NSUserDefaults standardUserDefaults];
        
    });
    return sharedManager;
    
}

+ (BOOL)saveBool:(BOOL)value forKey:(NSInteger)key{
    FCUserDefaults *fcDefault = [FCUserDefaults shareManager];
    [fcDefault.defaults setBool:value forKey:[NSString stringWithFormat:@"FCUserDefaults%ld",(long)key]];
    [fcDefault.defaults synchronize];
    return YES;
}

+ (BOOL)saveIntger:(NSInteger)value forKey:(NSInteger)key{
    FCUserDefaults *fcDefault = [FCUserDefaults shareManager];
    [fcDefault.defaults setInteger:value forKey:[NSString stringWithFormat:@"FCUserDefaults%ld",(long)key]];
    [fcDefault.defaults synchronize];
    return YES;
}

+(BOOL)saveObject:(id)value forKey:(NSInteger)key{
    FCUserDefaults *fcDefault = [FCUserDefaults shareManager];
    [fcDefault.defaults setObject:value forKey:[NSString stringWithFormat:@"FCUserDefaults%ld",(long)key]];
    [fcDefault.defaults synchronize];
    return YES;
}

+(id)objectForKey:(NSInteger)key{
    FCUserDefaults *fcDefault = [FCUserDefaults shareManager];
    id object = [fcDefault.defaults objectForKey:[NSString stringWithFormat:@"FCUserDefaults%ld",(long)key]];
    [fcDefault.defaults synchronize];
    return object;
}

+ (NSInteger)intgerForKey:(NSInteger)key{
    FCUserDefaults *fcDefault = [FCUserDefaults shareManager];
    NSInteger value = [fcDefault.defaults integerForKey:[NSString stringWithFormat:@"FCUserDefaults%ld",(long)key]];
    [fcDefault.defaults synchronize];
    return value;
}

+(BOOL)boolForKey:(NSInteger)key{
    FCUserDefaults *fcDefault = [FCUserDefaults shareManager];
    BOOL value = [fcDefault.defaults boolForKey:[NSString stringWithFormat:@"FCUserDefaults%ld",(long)key]];
    [fcDefault.defaults synchronize];
    return value;
}

@end
