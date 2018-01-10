//
//  FCRegisterDataModel.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/25.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FCRegisterDataModel : JSONModel

// 手机号
@property (nonatomic, copy) NSString *telphone;

// 密码
@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) int register_id;

@end
