//
//  JYSListenDetailModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/3.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSListenDetailModel.h"

@implementation JYSListenDetailModel
+(instancetype)listenDetailModelWithDic:(NSDictionary *)dic{
    
    JYSListenDetailModel *model = [JYSListenDetailModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
