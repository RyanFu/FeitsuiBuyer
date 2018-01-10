//
//  FCUserDataModel.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/26.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCUserDataModel.h"

@implementation FCUserDataModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                          @"user_id":@"id"
                                                    }];
}

@end
