//
//  JYSCityNewsModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/5.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSCityNewsModel.h"

@implementation JYSCityNewsModel

+(instancetype)dataWithDic:(NSDictionary *)dic{
    
    JYSCityNewsModel *model = [JYSCityNewsModel new];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key  isEqual: @"link"]) {
        self.url = value[@"url"];
    }
}


@end
