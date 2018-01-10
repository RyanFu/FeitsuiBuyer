//
//  FCTokenManager.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/26.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCTokenManager : NSObject

// 存储token
+(void)saveToken:(NSString *)token;

// 读取token
+(NSString *)getToken;

// 清空token
+(void)cleanToken;

@end
