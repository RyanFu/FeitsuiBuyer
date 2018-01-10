//
//  FCImageUploadManager.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/22.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCAPIListHeader.h"
/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,FCNetworkingRequestType) {
    /**
     *  get请求
     */
    FCNetworkingRequestTypeGet = 0,
    /**
     *  post请求
     */
    FCNetworkingRequestTypePost
};

@class FCUploadImageParams;

@interface FCNetworkingManager : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(NSDictionary *responseObject))success
                 failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(NSDictionary *responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 */
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(FCNetworkingRequestType)type
                     success:(void (^)(NSDictionary *responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(FCUploadImageParams *)uploadParam
                    success:(void (^)(NSDictionary *responseObject))success
                    failure:(void (^)(NSError *error))failure;

@end
