//
//  FCArticleModel.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/27.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class FCArticleDataModel;
@interface FCArticleModel : JSONModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) FCArticleDataModel *data;

@end
