//
//  FCRegisterDataModel.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/25.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCRegisterDataModel.h"

@implementation FCRegisterDataModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"register_id":@"id",
                                                                  }];
}

@end
