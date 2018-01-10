//
//  FCSearchSelectModel.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/20.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <JSONModel.h>

@interface FCSearchSelectModel : JSONModel


@property (nonatomic, copy) NSString *cat_name;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *deleted_at;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSArray *type;
@end
