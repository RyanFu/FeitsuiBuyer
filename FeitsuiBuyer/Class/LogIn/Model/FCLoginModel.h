//
//  FCLoginModel.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/25.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@class FCLoginDataModel;
@interface FCLoginModel : JSONModel

@property (nonatomic, assign) int code;

@property (nonatomic, copy) NSString<Optional> *data;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *status;

@end
