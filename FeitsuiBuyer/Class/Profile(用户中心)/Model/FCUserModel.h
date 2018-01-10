//
//  FCUserModel.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/26.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class FCUserDataModel;
@interface FCUserModel : JSONModel

@property (nonatomic, assign) int code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) FCUserDataModel *data;

@end
