//
//  JYSTalkDetailQuestionModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSTalkDetailQuestionModel : NSObject

@property(nonatomic,copy)NSString *questionId;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *relatedExpertId;

@property(nonatomic,copy)NSString *userName;

@property(nonatomic,copy)NSString *userHeadPicUrl;

@property(nonatomic,copy)NSString *state;


+(instancetype)talkDetailQuestionModelWithDic:(NSDictionary*)dic;

@end
