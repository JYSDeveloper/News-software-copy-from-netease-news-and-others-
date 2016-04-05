//
//  JYSTalkDetailModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTalkDetailModel.h"

@implementation JYSTalkDetailModel

+(instancetype)TalkDetailModelWithDic:(NSDictionary *)dic{
    
    JYSTalkDetailModel *model = [JYSTalkDetailModel new];
    model.questionModel = [JYSTalkDetailQuestionModel talkDetailQuestionModelWithDic:dic[@"question"]];
    model.answerModel = [JYSTalkDetailAnswerModel talkDetailAnswerModelWithDic:dic[@"answer"]];
//    NSArray *temp = dic[@"expert"][@"relatedNews"];
//    for (NSDictionary *tempDic in temp) {
//        JYSNewsModel *newsModel = [JYSNewsModel newsModelWithDic:tempDic];
//        [model.aboutNews addObject:newsModel];
//    }
    
    return model;
}


@end
