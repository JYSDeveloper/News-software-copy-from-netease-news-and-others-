//
//  JYSWebViewImgModel.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/29.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSWebViewImgModel : NSObject

@property(nonatomic,copy)NSString *src;

@property(nonatomic,copy)NSString *pixel;

@property(nonatomic,copy)NSString *ref;

@property(nonatomic,copy)NSString *width;

@property(nonatomic,copy)NSString *height;

+(instancetype)webViewImgWithDic:(NSDictionary*)dic;

+(instancetype)secondWebViewImgWithDic:(NSDictionary *)dic;

@end
