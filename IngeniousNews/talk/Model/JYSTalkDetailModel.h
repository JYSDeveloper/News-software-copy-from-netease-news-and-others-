//
//  JYSTalkDetailModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYSTalkDetailAnswerModel.h"
#import "JYSTalkDetailQuestionModel.h"
#import "JYSNewsModel.h"

@interface JYSTalkDetailModel : NSObject

@property(nonatomic,retain)JYSTalkDetailAnswerModel *answerModel;

@property(nonatomic,retain)JYSTalkDetailQuestionModel *questionModel;


+(instancetype)TalkDetailModelWithDic:(NSDictionary*)dic;

@end
