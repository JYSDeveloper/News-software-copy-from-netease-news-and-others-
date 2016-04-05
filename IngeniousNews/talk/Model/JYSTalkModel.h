//
//  JYSTalkModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSTalkModel : NSObject


@property(nonatomic,copy)NSString *expertId;

@property(nonatomic,copy)NSString *alias;

@property(nonatomic,copy)NSString *stitle;

@property(nonatomic,copy)NSString *picurl;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *descriptions;
/** 用户头像*/
@property(nonatomic,copy)NSString *headpicurl;
/** 类别*/
@property(nonatomic,copy)NSString *classification;
/** 关注人数*/
@property(nonatomic,retain)NSNumber *concernCount;
/** 提问*/
@property(nonatomic,retain)NSNumber *questionCount;
/** 标题*/
@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)NSInteger answerCount;

+(instancetype)talkModelWithDic:(NSDictionary*)dic;


@end
