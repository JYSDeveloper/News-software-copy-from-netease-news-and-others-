//
//  MHNetWorkTask.h
//  MintHome
//
//  Created by ZC on 15/12/1.
//  Copyright © 2015年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
//请求成功的block类型
typedef void(^SuccessBlock)(id result);
//请求失败的block类型
typedef void(^FailBlock)(NSError *error);
/**
 *  返回值类型
 */
typedef NS_ENUM(NSUInteger, ResponseType) {
    /**
     *  JSON
     */
    ResponseTypeJSON,
    /**
     *  XML
     */
    ResponseTypeXML,
    /**
     *  Data
     */
    ResponseTypeData,
    
    
};
/**
 *  Body类型
 */
typedef NS_ENUM(NSUInteger, BodyType) {
    /**
     *  字符串
     */
    BodyTypeString,
    /**
     *  字典
     */
    BodyTypeDictionary
};

@interface MHNetWorkTask : NSObject

/**
 *  GET请求
 *
 *  @param url          URL
 *  @param parameter    参数
 *  @param httpHeader   请求头
 *  @param responseType 返回值类型
 *  @param success      成功
 *  @param fail         失败
 */
+ (void)getWithURL:(NSString *)url withParameter:(NSDictionary *)parameter withHttpHeader:(NSDictionary *)httpHeader withResponseType:(ResponseType)responseType withSuccess:(SuccessBlock)success withFail:(FailBlock)fail;

/**
 *  POST请求
 *
 *  @param url          URL
 *  @param body         body体
 *  @param bodyType     body体类型
 *  @param httpHeader   请求头
 *  @param responseType 返回值类型
 *  @param success      成功
 *  @param fail         失败
 */

+ (void)postWithURL:(NSString *)url withBody:(id)body withBodyType:(BodyType)bodyType withHttpHeader:(NSDictionary *)httpHeader withResponseType:(ResponseType)responseType withSuccess:(SuccessBlock)success withFail:(FailBlock)fail;

@end
