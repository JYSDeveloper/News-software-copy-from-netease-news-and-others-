//
//  JYSCityMessageModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/5.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSCityMessageModel.h"

@implementation JYSCityMessageModel

+(instancetype)cityMessageModelWithDic:(NSDictionary *)dic{
    
    JYSCityMessageModel *model = [JYSCityMessageModel new];
    
    model.name = dic[@"name"];
    
    model.cityID = dic[@"id"];
    
    model.type = dic[@"type"];
    
    return model;
    
}

@end
