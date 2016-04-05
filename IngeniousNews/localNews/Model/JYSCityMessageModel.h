//
//  JYSCityMessageModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/5.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSCityMessageModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *cityID;


+(instancetype)cityMessageModelWithDic:(NSDictionary*)dic;

@end
