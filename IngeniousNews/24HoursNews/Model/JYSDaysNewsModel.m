//
//  JYSDaysNewsModel.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSDaysNewsModel.h"

@implementation JYSDaysNewsModel


+(instancetype)daysNewsModelWithDic:(NSDictionary *)dic{
    
    JYSDaysNewsModel *model = [JYSDaysNewsModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
