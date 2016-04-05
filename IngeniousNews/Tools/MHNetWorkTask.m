//
//  MHNetWorkTask.m
//  MintHome
//
//  Created by ZC on 15/12/1.
//  Copyright © 2015年 ZC. All rights reserved.
//

#import "MHNetWorkTask.h"

@implementation MHNetWorkTask

+ (void)getWithURL:(NSString *)url withParameter:(NSDictionary *)parameter withHttpHeader:(NSDictionary *)httpHeader withResponseType:(ResponseType)responseType withSuccess:(SuccessBlock)success withFail:(FailBlock)fail {
    
//    检查管理器单例的startMonitoring，用来检查网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    检查网络连接的单例，网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
      //  NSLog(@"%ld", status);
    }];
    
    
//   1.初始化sessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    2.处理请求头
    if (httpHeader) {
        for (NSString *key in httpHeader.allKeys) {
            [manager.requestSerializer setValue:httpHeader[key] forHTTPHeaderField:key];
        }
    }
//    3.判断返回值类型
    switch (responseType) {
        case ResponseTypeJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
            case ResponseTypeData:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
            case ResponseTypeXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
    }
//    4.判断返回值接受的具体类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
//    5.get请求
    [manager GET:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    
}

+ (void)postWithURL:(NSString *)url withBody:(id)body withBodyType:(BodyType)bodyType withHttpHeader:(NSDictionary *)httpHeader withResponseType:(ResponseType)responseType withSuccess:(SuccessBlock)success withFail:(FailBlock)fail {
//    1.初始化sessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    2.处理body体
    switch (bodyType) {
        case BodyTypeDictionary:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case BodyTypeString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
                return parameters;
            }];
            break;
    }
//    3.处理请求头
    if (httpHeader) {
        for (NSString *key in httpHeader.allKeys) {
            [manager.requestSerializer setValue:httpHeader[key] forHTTPHeaderField:key];
        }
    }
//    4.处理返回值类型
    switch (responseType) {
        case ResponseTypeJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ResponseTypeData:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case ResponseTypeXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
    }
//    5.判断返回值接受的具体类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
//    6.POST请求
    [manager POST:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}
@end
