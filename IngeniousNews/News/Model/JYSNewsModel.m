//
//  JYSNewsModel.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSNewsModel.h"

@implementation JYSNewsModel



+(instancetype)newsModelWithDic:(NSDictionary *)dic{
    
    JYSNewsModel *model = [JYSNewsModel new];
    [model setValuesForKeysWithDictionary:dic];
//    if ([model.skipType  isEqual: @"photoset"]) {
//        NSLog(@"%@",model.skipID);
//    }
    return model;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
