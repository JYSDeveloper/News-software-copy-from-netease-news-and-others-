//
//  JYSNetWorkTools.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSNetWorkTools.h"
#import "MHNetWorkTask.h"
#import "JYSNewsModel.h"
#import "JYSCityGroupModel.h"
#import "JYSTalkDetailModel.h"
@implementation JYSNetWorkTools


+(void)NetWork_GetDaysNewsInfoResult:(daysNewsBlock)block{
    
    [MHNetWorkTask getWithURL:DaysNewsURL withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSMutableArray *arr = [NSMutableArray new];
        result = [result objectForKey:@"T1429173683626"];
        for (NSDictionary *temp in result) {
            JYSNewsModel *model = [JYSNewsModel newsModelWithDic:temp];
            [arr addObject:model];
            
        }
        block(arr);
        
    } withFail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

+(void)NetWork_GetCitysMessageResult:(cityMessageBlock)block{
    
    [MHNetWorkTask getWithURL:CITYSMESSAGEURL withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        result = result[@"list"];
        NSArray *keyArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        NSMutableArray *blockArr = [NSMutableArray new];
        for (NSString *key in keyArr) {
            NSMutableArray *cityGroup = result[key];
            if (cityGroup) {
                JYSCityGroupModel *model = [JYSCityGroupModel new];
                model.title = key;
                model.citys = cityGroup;
                [blockArr addObject:model];
            }
        }
        block(blockArr);
    } withFail:^(NSError *error) {
        
    }];
    
}

+(void)NetWork_GetTalkInfoWithID:(NSString *)ID Hot:(hotAndLateMessageBlock)Block{
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/qa/%@.html",ID];
    NSMutableArray *hot = [NSMutableArray new];
    NSMutableArray *late = [NSMutableArray new];
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSArray *hotArr = result[@"data"][@"hotList"];
        NSArray *lateArr = result[@"data"][@"latestList"];
        for (NSDictionary *temp in hotArr) {
            JYSTalkDetailModel *hotModel = [JYSTalkDetailModel TalkDetailModelWithDic:temp];
            [hot addObject:hotModel];
        }
        for (NSDictionary *temp in lateArr) {
            JYSTalkDetailModel *lateModel = [JYSTalkDetailModel TalkDetailModelWithDic:temp];
            [late addObject:lateModel];
        }
        Block(hot,late);
        
    } withFail:^(NSError *error) {
        
    }];
    
}

+(void)NetWork_GetTalkMessageWithURLString:(NSString *)urlStr Block:(arrBlock)block{
    
    [MHNetWorkTask getWithURL:urlStr withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        NSArray *data = result[@"data"];
        NSMutableArray *back = [NSMutableArray new];
        if (data != nil) {
            for (NSDictionary *dic in data) {
                JYSTalkDetailModel *model = [JYSTalkDetailModel TalkDetailModelWithDic:dic];
                [back addObject:model];
            }
        }
        
        block(back);
    } withFail:^(NSError *error) {
        
    }];
    
}

@end
