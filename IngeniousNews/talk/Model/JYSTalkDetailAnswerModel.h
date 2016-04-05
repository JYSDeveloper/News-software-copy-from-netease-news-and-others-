//
//  JYSTalkDetailAnswerModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSTalkDetailAnswerModel : NSObject

@property(nonatomic,copy)NSString *answerId;

@property(nonatomic,copy)NSString *board;

@property(nonatomic,copy)NSString *commentId;

@property(nonatomic,copy)NSString *relatedQuestionId;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *specialistName;

@property(nonatomic,copy)NSString *specialistHeadPicUrl;

@property(nonatomic,retain)NSNumber *cTime;

+(instancetype)talkDetailAnswerModelWithDic:(NSDictionary*)dic;

@end
