//
//  JYSSpecialModel.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/3/1.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSSpecialModel.h"
#import "JYSNewsModel.h"
@implementation JYSSpecialModel


+(instancetype)specialModelWithDic:(NSDictionary *)dic{
    
    JYSSpecialModel *model = [JYSSpecialModel new];
    model.index = dic[@"index"];
    model.tname = dic[@"tname"];
    model.shortname = dic[@"shortname"];
    model.type = dic[@"type"];
    model.news = [NSMutableArray new];
    NSArray *temp = dic[@"docs"];
    for (NSDictionary *tempDic in temp) {
        JYSNewsModel *newsModel = [JYSNewsModel newsModelWithDic:tempDic];
        [model.news addObject:newsModel];
    }
    
    return model;
}

@end
