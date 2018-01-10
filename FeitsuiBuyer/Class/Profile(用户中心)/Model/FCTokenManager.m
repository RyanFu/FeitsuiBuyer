//
//  FCTokenManager.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/26.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCTokenManager.h"

NSString *const TOKEN_KEY = @"token";

@implementation FCTokenManager

// 存储token
+(void)saveToken:(NSString *)token {
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSData *tokenData = [NSKeyedArchiver archivedDataWithRootObject:token];
    [userDefaults setObject:tokenData forKey:TOKEN_KEY];
    [userDefaults synchronize];
}

// 读取token
+(NSString *)getToken {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *tokenData = [userDefaults objectForKey:TOKEN_KEY];
    NSString *token = [NSKeyedUnarchiver unarchiveObjectWithData:tokenData];
    [userDefaults synchronize];
    return token;
}

// 清空token
+(void)cleanToken {
    NSUserDefaults *UserLoginState = [NSUserDefaults standardUserDefaults];
    [UserLoginState removeObjectForKey:TOKEN_KEY];
    [UserLoginState synchronize];
}

@end
