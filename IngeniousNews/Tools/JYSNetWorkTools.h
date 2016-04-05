//
//  JYSNetWorkTools.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DaysNewsURL @"http://c.m.163.com/nc/article/list/T1429173683626/0-20.html"
#define HEADLINEURL @"http://api.iclient.ifeng.com/ClientNews?id=SYLB10,SYDT10,SYRECOMMEND"

#define CITYSMESSAGEURL @"http://api.irecommend.ifeng.com/citylist.php"

typedef void(^daysNewsBlock) (NSMutableArray *arr);
typedef void(^cityMessageBlock) (NSMutableArray *arr);
typedef void(^hotAndLateMessageBlock) (NSMutableArray *hot,NSMutableArray *late);
typedef void(^arrBlock) (NSMutableArray *result);
@interface JYSNetWorkTools : NSObject


+(void)NetWork_GetDaysNewsInfoResult:(daysNewsBlock)block;

+(void)NetWork_GetCitysMessageResult:(cityMessageBlock)block;

+(void)NetWork_GetTalkInfoWithID:(NSString*)ID Hot:(hotAndLateMessageBlock)Block;

+(void)NetWork_GetTalkMessageWithURLString:(NSString*)urlStr Block:(arrBlock)block;

@end
