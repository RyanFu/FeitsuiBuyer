//
//  FCSlideModel.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2018/1/6.
//  Copyright © 2018年 JourneyYoung. All rights reserved.
//

#import "JSONModel.h"

@interface FCSlideModel : JSONModel

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *deleted_at;

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *url;

@end
