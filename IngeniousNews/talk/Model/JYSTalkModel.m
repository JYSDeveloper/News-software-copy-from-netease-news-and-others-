//
//  JYSTalkModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTalkModel.h"

@implementation JYSTalkModel

+(instancetype)talkModelWithDic:(NSDictionary *)dic{
    JYSTalkModel *model = [JYSTalkModel new];
    
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqual:@"description"]) {
        self.descriptions = value;
    }
}


@end
