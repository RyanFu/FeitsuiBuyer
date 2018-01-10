//
//  FCProfileUserModel.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/25.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCProfileUserModel : NSObject

// 用户昵称
@property (nonatomic, copy) NSString *nickname;

// 头像
@property (nonatomic, copy) NSString *logo;

// 邮箱
@property (nonatomic, copy) NSString *email;

@end
