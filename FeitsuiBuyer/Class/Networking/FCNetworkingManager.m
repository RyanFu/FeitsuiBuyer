//
//  FCImageUploadManager.m
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/22.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCNetworkingManager.h"
#import <AFNetworking.h>
#import "FCUploadImageParams.h"

static const NSString *baseURL = @"http://temp.cqquality.com";

@interface FCNetworkingManager ()


@end

@implementation FCNetworkingManager

+ (void)getWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",baseURL,URLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = 60.f;
    
    [manager GET:requestURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if([responseObject isKindOfClass:[NSData class]]){
                NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                success(jsonDict);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",baseURL,URLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:requestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if([responseObject isKindOfClass:[NSData class]]){
                NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                success(jsonDict);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)requestWithURLString:(NSString *)URLString parameters:(id)parameters type:(FCNetworkingRequestType)type success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",baseURL,URLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    switch (type) {
        case FCNetworkingRequestTypeGet:
        {
            [manager GET:requestURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    if([responseObject isKindOfClass:[NSData class]]){
                        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                        success(jsonDict);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case FCNetworkingRequestTypePost:
        {
            [manager POST:requestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    if([responseObject isKindOfClass:[NSData class]]){
                        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                        success(jsonDict);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
    }
}

+ (void)uploadWithURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(FCUploadImageParams *)uploadParam success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",baseURL,URLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:requestURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if([responseObject isKindOfClass:[NSData class]]){
                NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                success(jsonDict);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
