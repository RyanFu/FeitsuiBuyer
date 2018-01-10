//
//  FCArticleCatDataModel.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/27.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FCArticleCatDataModel : JSONModel

@property (nonatomic, assign) int cat_id;

@property (nonatomic, copy) NSString *cat_name;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, copy) NSString *article;

@end
