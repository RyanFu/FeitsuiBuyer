//
//  FCSearchInfoModel.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/20.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <JSONModel.h>
#import "FCSearchSelectModel.h"

@interface FCSearchInfoModel : JSONModel

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *deleted_at;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSDictionary *pivot;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, copy) NSString *type_val;
@property (nonatomic, copy) NSString *updated_at;

@end
