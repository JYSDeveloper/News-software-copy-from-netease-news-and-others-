//
//  JYSSecondWebImageModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/4.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSSecondWebImageModel.h"

@implementation JYSSecondWebImageModel
+(instancetype)ModelWithDic:(NSDictionary *)dic{
    
    JYSSecondWebImageModel *model = [JYSSecondWebImageModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
