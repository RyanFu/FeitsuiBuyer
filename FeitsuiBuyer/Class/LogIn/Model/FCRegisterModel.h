//
//  FCRegisterModel.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/25.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class FCRegisterDataModel;
@interface FCRegisterModel : JSONModel

@property (nonatomic, assign) int code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) FCRegisterDataModel<Optional> *data;

@end
