//
//  JYSTalkDetailQuestionModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTalkDetailQuestionModel.h"

@implementation JYSTalkDetailQuestionModel

+(instancetype)talkDetailQuestionModelWithDic:(NSDictionary*)dic{
    
    JYSTalkDetailQuestionModel *model = [JYSTalkDetailQuestionModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
