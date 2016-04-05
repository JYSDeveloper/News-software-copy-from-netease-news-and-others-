//
//  JYSSecondWebModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/4.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSSecondWebModel.h"
#import "JYSSecondWebImageModel.h"
@implementation JYSSecondWebModel

+(instancetype)secondWebModelWithDic:(NSDictionary *)dic{
    
    JYSSecondWebModel *model = [JYSSecondWebModel new];
    model.content = dic[@"content"];
    NSArray *temp = dic[@"media"];
    model.imageArr = [NSMutableArray new];
    for (NSDictionary *tempDic in temp) {
        JYSSecondWebImageModel *childModel = [JYSSecondWebImageModel ModelWithDic:tempDic];
        [model.imageArr addObject:childModel];
    }
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
