//
//  JYSListenModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/2.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSListenModel.h"

@implementation JYSListenModel


+(instancetype)listenModelWithDic:(NSDictionary *)dic{
    
    JYSListenModel *model = [JYSListenModel new];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqual:@"id"]) {
        self.ID = value;
    }
    
}

@end
