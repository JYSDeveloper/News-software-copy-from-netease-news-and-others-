//
//  JYSCityNewsModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/5.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSCityNewsModel : NSObject

@property(nonatomic,copy)NSString *thumbnail;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *source;

@property(nonatomic,copy)NSString *updateTime;

@property(nonatomic,copy)NSString *documentId;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *commentsUrl;

@property(nonatomic,retain)NSNumber *comments;

@property(nonatomic,copy)NSString *url;

+(instancetype)dataWithDic:(NSDictionary*)dic;


@end
