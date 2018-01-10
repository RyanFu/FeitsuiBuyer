//
//  FCUserDataModel.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/26.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FCUserDataModel : JSONModel

@property (nonatomic, assign) int user_id;

@property (nonatomic, copy) NSString *telphone;

@property (nonatomic, copy) NSString<Optional> *nickname;

@property (nonatomic, copy) NSString<Optional> *logo;

@property (nonatomic, copy) NSString<Optional> *email;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, assign) int deleted_at;



@end
