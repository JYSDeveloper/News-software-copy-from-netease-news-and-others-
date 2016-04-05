//
//  JYSLiveModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/12.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSLiveModel.h"
#import "JYSLiveMessageModel.h"
@implementation JYSLiveModel


+(instancetype)liveModelWithDic:(NSDictionary *)dic{
    
    JYSLiveModel *model = [JYSLiveModel new];
    model.section = dic[@"section"];
    model.bannerImageUrl = dic[@"banner"][@"url"];
    model.messages = [NSMutableDictionary new];
    NSArray *messageArr = dic[@"messages"];
    for (NSDictionary *temp in messageArr) {
        JYSLiveMessageModel *messageModel = [JYSLiveMessageModel liveMessageModelWithDic:temp];
        NSArray *searchArr = [model.messages objectForKey:messageModel.section];
        if (searchArr == nil) {
            [model.messages setObject:@[messageModel] forKey:messageModel.section];
        }
        else{
            searchArr = [searchArr arrayByAddingObject:messageModel];
            [model.messages setObject:searchArr forKey:messageModel.section];
        }
    }
    return model;
}

@end
