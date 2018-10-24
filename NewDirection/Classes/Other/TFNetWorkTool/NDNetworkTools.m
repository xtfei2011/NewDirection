//
//  NDNetworkTools.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDNetworkTools.h"
#import <AFNetworking.h>

@implementation NDNetworkTools
#pragma mark -------  GET 请求数据
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [manger.requestSerializer setValue:@"ios" forHTTPHeaderField:@"apptype"];
    [manger.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"version"];
    
    NSMutableSet *setM = [manger.responseSerializer.acceptableContentTypes mutableCopy];
    [setM addObject:@"text/plain"];
    [setM addObject:@"text/html"];
    manger.responseSerializer.acceptableContentTypes = [setM copy];
    
    [manger GET:Common_Interface_Montage(url) parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -------  POST 请求数据
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [manger.requestSerializer setValue:@"ios" forHTTPHeaderField:@"apptype"];
    [manger.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"version"];
    
    NSMutableSet *setM = [manger.responseSerializer.acceptableContentTypes mutableCopy];
    [setM addObject:@"text/plain"];
    [setM addObject:@"text/html"];
    manger.responseSerializer.acceptableContentTypes = [setM copy];
    
    [manger POST:Common_Interface_Montage(url) parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
